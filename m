Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81116F896
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 08:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBZHgm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 02:36:42 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:8517
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbgBZHgm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Feb 2020 02:36:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrGCc/GTgB0j2/NuNo35Cp5y5Gg6sJBH0bU+CoLb7eBVqiW4nwaYQws81wN2Mtfs3X1OyJ11Rrme/Uu6TkCM2qYKlKlEu5Sxmvp/tRoFqLMHcyLpzmrOGzNARxTGAoFN/XJ61/qe1L/GOQcCywv+cKjlLlcT9lWEn6A2PAQX6+wmd54vjm0ti1IgQB9DfqnfmGPyojUg2phh+craNU/iTLBxthivKb0S/YEs6+o81urx+kRRGyflIuVw/RYcaCoKoKcVoi9+D9LejkJUYiBf9ZR8szDr7aQaqyYK9+a90mr2sT7/7cmIW/eQCdS9lMEpKqE4p2rEdD2bZ4HIuG2slg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YODDnTjyxe6pqzx0BlPTpPXc4qgxtLs7ESMvFOGEaH0=;
 b=XyterC2qmTNVAkVnQuNdNoveT3iSx8EkPyjUwZ/rK6Q9xYIZrcOOeFXexZi1WWUpHvfLT1mis6ROidd/gpdmXtdRoh3s6A2acxxVoEpcv+18K95vGo3QfhXCAnvSEDwTzl9a48uYodrZZe+8UywF4MtpTjwdyt/ctjE4jYYddWG3DzVOnwvkS3ED9Me6EztroDe5loAkIb1jPmp0yJpqwktQwoVTpidJNQ5iBiW531i+4Ymoz+VgBOBZ3bFvg0q/oLn6AUc0dg4B7EW6QslZQPgzt58E15xqTXMIEpLLkt1AugzAoz+3TuGVXJX0fI88hw05YYS3ICDhWDB9hANQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YODDnTjyxe6pqzx0BlPTpPXc4qgxtLs7ESMvFOGEaH0=;
 b=m4sAPiBqKoDHoQGJErRkSaNKfyftZj54MNz7xGHqfItyg5FooP17ZdWodVDNKoqe0dSW3+iwZM01+rYDwDw86OUvWTuOjb+DISDoLrEBJpHyDptUSeYzHgArkq/5jA/VlhhYyGHUEWtj5Wv1C1uFgYf1leO/+I12L/iaJFfn7b8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stefan.herbrechtsmeier-oss@weidmueller.com; 
Received: from AM0PR08MB5201.eurprd08.prod.outlook.com (10.255.29.28) by
 AM0PR08MB4611.eurprd08.prod.outlook.com (20.178.83.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 26 Feb 2020 07:36:39 +0000
Received: from AM0PR08MB5201.eurprd08.prod.outlook.com
 ([fe80::b06a:37b5:4321:4d05]) by AM0PR08MB5201.eurprd08.prod.outlook.com
 ([fe80::b06a:37b5:4321:4d05%5]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 07:36:39 +0000
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
 <20200225155354.GF4633@sirena.org.uk>
From:   "Herbrechtsmeier Dr.-Ing. , Stefan" 
        <stefan.herbrechtsmeier-oss@weidmueller.com>
Message-ID: <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
Date:   Wed, 26 Feb 2020 08:36:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200225155354.GF4633@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM0PR08MB5201.eurprd08.prod.outlook.com
 (2603:10a6:208:15b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.36] (94.134.181.170) by FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 07:36:38 +0000
X-Originating-IP: [94.134.181.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d1ba947-9a03-4aee-dec7-08d7ba8e9d95
X-MS-TrafficTypeDiagnostic: AM0PR08MB4611:
X-Microsoft-Antispam-PRVS: <AM0PR08MB46114E005BD0902DD707406CD7EA0@AM0PR08MB4611.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(16526019)(26005)(66476007)(956004)(66556008)(66946007)(186003)(2616005)(5660300002)(2906002)(52116002)(4326008)(478600001)(31686004)(86362001)(81156014)(81166006)(31696002)(6486002)(8676002)(36756003)(8936002)(6916009)(16576012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4611;H:AM0PR08MB5201.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: weidmueller.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRQzBQhE5GxOqVVvW6lN8Slni3eICdzborGwGCMvJ2t0Mp9VAZXNYQztUI+IEP5JGYQohwEU4JdPTkzsXXU9/P45zMc4HuGKe4KOsM/mvZo8It5IgfwDbnXZjqn3wRXTORWkPEYiKs94j3npNrLj4RIetlL7KSV9PkhghFc6zohN7TPyWl2kx9Z3j4GM5DBCbmSo29v9anUNtyvuo0/sZwsr3kfD2KX+i5WRa0rDPERx+U4zHjxJB3Ktf+Er+Aq/iRcU5Lmuwq84yYHDlGaSppgR2zSFTK7Suqqrdg9a3nQCxVCKhlSL2EmSCyKDzU591SRb7noTT7Zs/o9k8bxBWCWy8FBnl5aynyRJ4iXibECbbTTgf2RPTC2gJmdz5rJ9UGuySTRtIRhlZoZWWKxY4zHriCAmIsiwFWjeHzt1yRk+JBxp8AD4ceM5b+gLtF6t
X-MS-Exchange-AntiSpam-MessageData: wauOKfUyYMc7Bbv8PjTPPmonAPRG+cWX1QVcOE9PLr/WHjs8S27M5oXvTlTnYod1LgaRNM3uqB1hqcMBGIm1iBqlpDg5a8TmalG/V8/xuTmkzecE4uqe3cstIl3le0MvdEs1l+5BoFltvvZ5bFecoQ==
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1ba947-9a03-4aee-dec7-08d7ba8e9d95
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 07:36:38.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtOY97shPgJIgTQX7Qv5SiAWdO5rbbVSmkOkf1WAFTZ2tKLatYUeaJXTxQ91gbU30r+nMDDAM+yEvyfgrOfVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4611
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 25.02.2020 um 16:53 schrieb Mark Brown:
> On Tue, Feb 25, 2020 at 02:27:27PM +0100, Herbrechtsmeier Dr.-Ing. , Stefan wrote:
>
>> would it be acceptable to add an additional function to the struct
>> spi_controller which handle a transfer inside a NMI context or a panic? The
>> new function will transfer data via register polling without any lock.
> That would need to happen as part of a wider change that made it
> possible to use such an interface safely and did so, off the top of my
> head it's not immediately obvious how one would do that.  You'd need to
> get the hardware into a sensible state and then do whatever needs doing
> with some cooperation from the client driver in all this which is a bit
> of an ask.  It's not a trivial bit of work, but I do see the use case
> and it's absolutely valid.

I see two possible solutions.
a) The complexity is handled inside the client. The client uses the 
controller exclusive and isn’t allowed to use the new panic transfer 
during a normal transfer.
b) The complexity is handled inside the controller. The controller is 
shared between multiple slaves and a panic transfer must abort a running 
transfer.

The first solution keeps the controller driver simple because only a new 
polled transfer is needed. But the prepare and unprepare functions must 
be lock free and power management must be handled lock free to be reused.

The second solution could lead to code duplication because an addition 
panic prepare function must setup the controller from any state and must 
abort a running transfer. Especially the abort could be complex and 
difficult to test. Otherwise the new functionality could be used without 
any constraints.

