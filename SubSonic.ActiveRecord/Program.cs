using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Northwind;

namespace SubSonic.ActiveRecord
{
    class Program
    {
        static void Main(string[] args)
        {
            EmployeeCollection employees = new EmployeeCollection();
            employees.Load(Employee.FetchAll());

            foreach (Employee employee in employees)
            {
                Console.WriteLine("Employee ID: " + employee.EmployeeID.ToString());
                Console.WriteLine(" First Name: " + employee.FirstName);
                Console.WriteLine("  Last Name: " + employee.LastName);
                Console.WriteLine("      Title: " + employee.Title);
                Console.WriteLine("     Region: " + employee.Region);
                Console.WriteLine();
            }

            Console.ReadKey();
        }
    }
}
