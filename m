Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9E16C244
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgBYN1d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 08:27:33 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:43489
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbgBYN1d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Feb 2020 08:27:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qca4vvaWBwkRPFeGtQhOTi48KjQL0uugQli9lYJH/kdracB+jklEL1w2IkL2ovLOzvBeiTsws3r9eKXa41ZnSRRiWOJjYxFdu4erhGE8gLbAVmJ1uDonvsLjpqUssS7LegPXOfjW3ltigP40TzFY2f/v1Eg2bHDed+L7Mp+gTWrmJBWCt3oz3oKp+tBRgVPObzWaalLLQpQ6zZbCBZxy3HKvumQ/8O0YXGoZPRlHmXtKAzI3DQKEz9vxzPD6qv1/pXkIjOJL5biZjRp6SGG0s2LZX4udkNJRgBYTWO+KpZWoAmZhJhMPgMZskldptUZAoV8+Xcn7bmyHIYPRHYRUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXq5kFxj7+ImUhiyhErFM19+eVbHm6+tCeOdnkDomUY=;
 b=lYoQAX45kv3De3wEnMiQ/8dzavkAaRYrrJARQQOSg1ccJYhyaMugj2h/sMawwUc9qIElYLyl/qkTC3SADrlqyZieIPoBu6tfAQ2EFo12B90H6GiqK5YvN2aV0WoCd4/0G7YGNR1elCcxbcVZxUjPJOKiRtkO1/H3UdaXihsNf9Sm49jbqYFgTBl6AAnBktTCZcrrr/gq1JnJn9j5ZjLa2X5l+bqyIZIPDoTcXvMPR0jp6V0v8ZTMH700PjrCpoeipb1aQ2iYn+H6/uXM99g+JF+T+rvPWl+WrPtFJKX7UpHW7eABrS2AnsUSL9iLhkuTpHYNoQmBy7aPthw+FuDFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXq5kFxj7+ImUhiyhErFM19+eVbHm6+tCeOdnkDomUY=;
 b=nhhAT5+IEfhi3XcJattqUeGRPZIBp9ToX2wGb61hLYBt4sbdoq0ZnJa+YVXCbTy/U2zo+39F6MqgKZNzURnYC0X32hvP4cDxUY99f8bxYwiJrr+Xutnexbll5Ynp5XIMmEBTwk6DH/ABmxF6r3ICoDUvZE9RnTZfR/tcbCAelUI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stefan.herbrechtsmeier-oss@weidmueller.com; 
Received: from AM0PR08MB5201.eurprd08.prod.outlook.com (10.255.29.28) by
 AM0PR08MB3988.eurprd08.prod.outlook.com (20.178.202.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 13:27:28 +0000
Received: from AM0PR08MB5201.eurprd08.prod.outlook.com
 ([fe80::b06a:37b5:4321:4d05]) by AM0PR08MB5201.eurprd08.prod.outlook.com
 ([fe80::b06a:37b5:4321:4d05%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:27:28 +0000
From:   "Herbrechtsmeier Dr.-Ing. , Stefan" 
        <stefan.herbrechtsmeier-oss@weidmueller.com>
Subject: Execute spi transfers inside FIQ (NMI) or panic
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Message-ID: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
Date:   Tue, 25 Feb 2020 14:27:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0110.eurprd05.prod.outlook.com
 (2603:10a6:207:2::12) To AM0PR08MB5201.eurprd08.prod.outlook.com
 (2603:10a6:208:15b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.36] (94.134.181.151) by AM3PR05CA0110.eurprd05.prod.outlook.com (2603:10a6:207:2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 13:27:28 +0000
X-Originating-IP: [94.134.181.151]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 113cd7f3-dfbf-4c85-8572-08d7b9f675bd
X-MS-TrafficTypeDiagnostic: AM0PR08MB3988:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3988DE1132614EAB20C9D625D7ED0@AM0PR08MB3988.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(86362001)(6916009)(52116002)(36756003)(186003)(16526019)(4744005)(66946007)(5660300002)(66556008)(8676002)(81156014)(6486002)(26005)(2906002)(31686004)(81166006)(2616005)(478600001)(66476007)(956004)(8936002)(16576012)(316002)(31696002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3988;H:AM0PR08MB5201.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: weidmueller.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elqNBKmgGRoEUBIqPcmdRh6ukmlvr6KrQ+ZHB6xxFADx77C/0TVAt5PreK/5AMZcxB6z+r6aGzM2cAk9H5AFWLGVe/3eouIbA1paVmi2NPuWV3zvzkREToxhy2mqZ1m4mS6VWXVZUnxVU2RgZQxCIDU4Jd2wWHCnpudIWXn5qyw/5NjbtWHLTOkPXWu+/T2oLEt84y8JHBlkEZRZxpM6PMXvcMwMfQtyedj/yfP1bHSCoj52nqQf6D3BzTwP8d3cfAcwVcqLTMd9iFiRaIa1wFd7ipCG71/GwDl7ELHt14KoZM0MA1czF73inAklp+jRzTOQ+AZSTWfL6P/xxtKZaVso077wLumFdni1Mo/zYP3ciK1fbvVQdWQY7c4tTHb8NLeAtSHRnmMDjt7XUyDj2SvP8b9P7ulGGCV/wtbpIo5eMoGaYidgwVqYaTscwlmW
X-MS-Exchange-AntiSpam-MessageData: JyDenZTerP1ZGITx9i/DUJCiiyulHAWHsxvVZSxN8wasTPLCrO9Y7bGWDi/zX1z3yBtKh+2Ybm6KaWAkN9bWWuBWP1u/q10mRCYoRoN37Jm3W1L1LAHyAqv5sK6lz/2/mJ7GRq73Cru8GQ588w5udA==
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113cd7f3-dfbf-4c85-8572-08d7b9f675bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 13:27:28.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLQWO9CzR7x+xLo0OqhzRl8uoQEiB1f1JYNggOK1PwaUKpN1dPe+xeZjYvDsjxk/tjisxGBBu8F8soYCjmqzKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3988
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

would it be acceptable to add an additional function to the struct 
spi_controller which handle a transfer inside a NMI context or a panic? 
The new function will transfer data via register polling without any lock.

I must execute an SPI transfer inside a fast interrupt request (FIQ) 
handler or a panic. The FIQ is handled as a non-maskable interrupt 
(NMI). Both the panic and the NMI doesn't support any interrupts.

The background of the request is a non-volatile SPI memory with cached 
date in system memory. The cache must be synchronized back to the SPI 
memory after a power failure or panic.

Regards
   Stefan Herbrechtsmeier

**
