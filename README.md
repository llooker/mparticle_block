# mparticle-looker-blocks

mParticle is the most complete way to manage mobile data. Connect your data to a single SDK, built just for mobile. Send it instantly to the most relevant app services. With mParticle you can 

- Capture a comprehensive set of mobile data points that represents how users interact with mobile apps, such as custom app events, eCommerce transactions, app sessions, screen views, app state transitions (e.g., app going to background or coming to foreground), push messages, crashes, attribution sources, etc.
- Identify users with various types of user identities and track user attributes.
- Build audiences from your app users based on what they have done within your apps, and send resulting segments to ad platforms (facebook, twitter, appnexus, etc.) for marketing purposes.
- Get full access to the raw data you've captured so that your data scientists can perform their magic, either in Amazon Redshift or S3 or have us send data to your own servers.

mParticle Looker Blocks provide three dashboards:

1. **App Activity Dashboard**. This dashboard gives you an overview of most common app activities, including active user count, new user count, session count, average session length, revenue data, custom funnel analytics, and user retention analysis.
2. **Audience Dashboard**. This dashboard reports how effective an given audience is, comparing users in the audience to other app users. When looking at this dashboard, please make sure you provide a valid audience ID wrapped in quotes in the audience membership filter, e.g., "1234". You can get the audience ID from mParticle UI.
3. **eCommerce Dashboard**. This dashboard offers insights on revenue generated from your apps, e.g., which user acquisition channels gives you the most valuable users, how does total revenue and average revenue per user change over time, how do users' purchase behaviors change over the course of a day, and where do users drop off in the purchase funnel.
4. **App Version Dashboard**. This dashboard tells you how much a new app version has changed your app performance, e.g., has a new app version improved user retention, or increased revenue per user, or increased average session length, etc.

On all three dashboards, you can filter by date range and app platform. Note that in order for user retention chart to be meaningful, please make sure the event date filter and install date filter have the same date range.

