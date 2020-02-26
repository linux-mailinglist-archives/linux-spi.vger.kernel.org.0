Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA63170258
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBZP2X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 10:28:23 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:47265
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbgBZP2W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Feb 2020 10:28:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iahy61aen22HvDmi90YtKcTvCagiW4nTx1XbRkLz+IR48D4c1RfRReDIDmk8UT67TJS1j2R7ufIoJQfNNBbhEXxzB9FKxVgVJdXN5VZdsTe3AzxzMMVUyzogZYGZ90SKNsEHn0B/WDPX0CR0jAdyqOeA1ALdC2kjN4SUJKz1K5frdoEnbF4SzqiQWRYUGCSTpqi3POFb9U3NYQpW5fRoF6r7tQsFP6avCoxsFy2aWmRzQxrllwl0LwJkZvDm3I6PCEeZSFldeiXCWPBohjryavpVqtHj0NXV2AD5DTXRBApHmksTZ3CKj9CPeaIf8Nx+ZX3EdwsOPylLFkTFO2ppeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WQa1m3VXouR0HdAgCJ7HX+Vn0hpXRWOlC5y/RsuaXg=;
 b=dvX6B9CyUv3Diu8AVoCb1p2g03k4D02YfrNB7iv+osHobuNcmQzzTwHPOOTm6OMcZbZlvm4MMtsqfR/mNnCuThoUk6gvZ8aHkbjvZDakvWeU7E9TyNsHJZrl9gTsyrLPBSAiMzm3GGSsHpuDhOf4oJhd/CYWdWjWekscJo7HDDEvtCtleF6jJ6WPACleq4bozQTlR2pBE5IUebBgQZZr4oncKQxvEEXZlSZ++Flb+x2eW9GOYrMKGbcxkGJxNYY/SKytv1wC8QSGU4ypRtdMpSpu4dvtqyCtGwmgX4PbyiUGTdoH7niq8YIfKx5jzRwZEhkPph9QlXXE+ZaMuP1jMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WQa1m3VXouR0HdAgCJ7HX+Vn0hpXRWOlC5y/RsuaXg=;
 b=tEjeZHoUJd4rwOQqsSP8URT6vfUxwmIMcHYe9bc0j5wzWltsri9aCcFA2RzwNEE5P+C3s2N1nrdvlR7CCK0qWMOR/bq4Cw/ax/pEi+sMbOoKopBHi72HoaSeeoH0dW7HneQK05rIpAcK2/Q0GHOqusI2fwQzoL8ktiQw9jzSaJc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stefan.herbrechtsmeier-oss@weidmueller.com; 
Received: from AM0PR08MB5201.eurprd08.prod.outlook.com (10.255.29.28) by
 AM0PR08MB5283.eurprd08.prod.outlook.com (20.178.117.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 15:28:19 +0000
Received: from AM0PR08MB5201.eurprd08.prod.outlook.com
 ([fe80::b06a:37b5:4321:4d05]) by AM0PR08MB5201.eurprd08.prod.outlook.com
 ([fe80::b06a:37b5:4321:4d05%5]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 15:28:19 +0000
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
 <20200225155354.GF4633@sirena.org.uk>
 <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
 <20200226113333.GC4136@sirena.org.uk>
From:   "Herbrechtsmeier Dr.-Ing. , Stefan" 
        <stefan.herbrechtsmeier-oss@weidmueller.com>
Message-ID: <6a725569-db34-cf41-cb13-1b3d3a7aad23@weidmueller.com>
Date:   Wed, 26 Feb 2020 16:28:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200226113333.GC4136@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM0PR08MB5201.eurprd08.prod.outlook.com
 (2603:10a6:208:15b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.36] (94.134.181.170) by FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 15:28:18 +0000
X-Originating-IP: [94.134.181.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e92c4e11-85c1-48b0-7a3a-08d7bad081a6
X-MS-TrafficTypeDiagnostic: AM0PR08MB5283:
X-Microsoft-Antispam-PRVS: <AM0PR08MB5283D5747987A27BF6294F90D7EA0@AM0PR08MB5283.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(2616005)(2906002)(6916009)(956004)(16576012)(31696002)(66946007)(66556008)(86362001)(36756003)(316002)(52116002)(4326008)(66476007)(81166006)(81156014)(4744005)(478600001)(8676002)(16526019)(26005)(186003)(6486002)(5660300002)(31686004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5283;H:AM0PR08MB5201.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: weidmueller.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQprBsmHYyyugCDotzyNvFt6n5NLvGfiZ3yVZtkhOHeT+UfeotnHGq1n+0Dkfko96QSmAZW7wwLX0Nen4Mt86q2c9AJY5wEajvbkF2z0yMMdJ/EUT9tPi7P/7DmdOXsvmqJ3XKtZX++St3UgJjadnMoeeKChtl+yR18Vo/2VId9m3u4LdEVWHXt9pj5QGy4eJhEiIgfOoOTzvGkqtAsZPrb+h+V5wNf5FD6banb5z2/5guMmNyIZc8u5OAUqu4WnKFhF9lA3EPq92MSCvanaJJ7X3byYnUwmZhC6rv+0nsvLhno7SpTkJEgBM0Y17h3E2DWQt3Ak3J8sWmPLHpwj8ViK4dJE1kWdfpvpzGLRWnWMgunaMdaoEdU0FvqeqzvF//Q3VaBzGuWBBnUHjxfZOAyNsAnWgB4h1+PVO5XdmX39voEigQknAwNwVMxLu2fl
X-MS-Exchange-AntiSpam-MessageData: pUk6EEnWyFo9H3/Z1FjPIe/3ZPnzPTr/DUN1ZP/AV8qWZuI3aoOqmc4SFjLbrJDMoD5dlsCWtlB+ce+SO3eGNBw0zFJgeWCm0r+r9NnW0jj27dyK013jOLB/dU9JxwPeMgs5Xla5er7mFcMisyiSRA==
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92c4e11-85c1-48b0-7a3a-08d7bad081a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 15:28:19.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2mXQVAzG2qcKZRxM0GWwuCacYa//PJXpaaMaXfD4c/QM9SCXrzKXShOqtiD6tqXiC/QQIN14p3YNfZ7amrZuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5283
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 26.02.2020 um 12:33 schrieb Mark Brown:
> On Wed, Feb 26, 2020 at 08:36:37AM +0100, Herbrechtsmeier Dr.-Ing. , Stefan wrote:
>
>> I see two possible solutions.
>> a) The complexity is handled inside the client. The client uses the
>> controller exclusive and isn’t allowed to use the new panic transfer during
>> a normal transfer.
> Then someone builds a system with two devices attached to a single SPI
> controller...  besides, you've got no mechanism for controlling when a
> kernel might panic or power might be lost.  I'm not sure a scheme that
> relies on being able to control when stuff happens is going to be what
> you need.

In my case this works because I read from the device during probe and 
write to the device during a panic or after power failure. But I 
understand that this isn't a generic solution.
