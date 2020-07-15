Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74D2220C13
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgGOLp5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 07:45:57 -0400
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:22971
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729546AbgGOLp5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 07:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FATbkbSZsVzlzILW503Cx3Me75ZPlFfSETDAB3GSXS3GTjEUfHFgvj3vwI9qO6quwESfOT0QFr8Fu/2Uu+NaYJYmrFst7PMSTgKTsvyjdMuJSBm2pO5qRt/uHmhVgYniWIh7wNRE7ouCPORCQoQboER+Pdsjc6+vv3vLub2SrPvuo6XFXv85rd9E5WJCX/T8IkJcNYfwfcqDkbFEtn4xCqV2pIGRfwrK3KrrJm0vKFVhSNbMt+Y9HiRr/Fah8XZD5FJ9LLQJ121qfJgGw59RqZSTNjLiMlpETcFmMQ9BQSxuomsyrHk5OvbvxDjBrm2rk6VNEqdGOD21xq2fE+cV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPFb3buB86fU5NePK+V2bYP4aXx9AJqRozT56I/Okog=;
 b=NHt1rvvFvImuQRQelCgVZQYGkKHJLoge6Q3thlBTV3p0p7aYhWCWlJot2Ie2F8jxW9XHPt+/c/3EoEKED0H0REpX7pWrVTUIxnYdCVR5fLxM+SaGjGneMRSpliOy/y6+wp3qd4PySwE4zI5xh++I5TO3QQq8mAroRMs3xctmni4a4Ta01HqIAMBbq7RdChhD8WZoGS31OisNulyeR+p1fRndWDWXPQXzacmHRo8i5u7PLRtbf/9UCjjEMepwF1+h4lVLk6nbbQ0EyfMdM3PRqbkAgly2v9pJYB8Eo6HNB0CM1YsIF77GjJCqhiZG/JGaHHPxBUdWx4Wp5ZH5c231Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPFb3buB86fU5NePK+V2bYP4aXx9AJqRozT56I/Okog=;
 b=l/bjSlcFlX/RoEdkPC3n6hhIdVo8IVcTrEWO5F41xVEKfQoHgPGIZIxvV1zq52UcAWPQVjwn1kezyS0oEIunQcSFMHRrAEEHV0mKtC3isblSAjTpVfDREfKjNoMn4hENIcgI+U1cAmPyEif0I253mjzAm/ELX+tm34yrd9XJUYA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB7PR10MB2042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Wed, 15 Jul 2020 11:45:52 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 11:45:52 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
 <20200714192907.GJ4900@sirena.org.uk>
 <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
 <20200715113609.GD5431@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <824b8479-e204-d087-7887-a2dbefa0f844@kontron.de>
Date:   Wed, 15 Jul 2020 13:45:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200715113609.GD5431@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:208:136::35) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (109.250.128.36) by AM0PR05CA0095.eurprd05.prod.outlook.com (2603:10a6:208:136::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 11:45:52 +0000
X-Originating-IP: [109.250.128.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fc5dd2-01c4-4713-f0a8-08d828b4a08b
X-MS-TrafficTypeDiagnostic: DB7PR10MB2042:
X-Microsoft-Antispam-PRVS: <DB7PR10MB2042358677889DEA5D88B63AE97E0@DB7PR10MB2042.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZCKcjrMNED0JGxqGnNpbTbIdFSNYshQERBXyBNm2mTAUdiBkqpJ5rznXgZ9q0/WdF8HKeCwRJncFEmo1CJLPRKvBw9R7/QYU/wHNb6TjLwha5icQfc/c0WFB/zXD1IZfqoFTMZMQtSWA7Yn4dTMs45m8WQLchmCUDugWJ06NSmKU+N1vnvujjL6n/mPkohBxTGDrszE7kk4KymRUAyBnF9e0JPJAP5a+x64zH1omaf2/MulKB16/lpHEKg5mrJAzoTwGZ0hgsjm8iT1v0cY8mDdjijPwS5UWO2uktEvrmMhgcrWrcj3XFQ5m+CQ4CvGRjadaQ3BspihairammfNriB+RCOCpagjokAUnq9iPtHmGRPFeLgWS0THPZ/J50k0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(2906002)(16576012)(83380400001)(478600001)(4326008)(316002)(66556008)(66476007)(66946007)(36756003)(6486002)(26005)(8676002)(86362001)(16526019)(186003)(31696002)(31686004)(8936002)(53546011)(5660300002)(6916009)(2616005)(956004)(52116002)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: egCfqU1mAyyvoa/QPsmztyJwTBgZh2bZYpDTQhYEA06E+MPb6SRiUNVQ0i3lIFhqd1WhtvHA9eDCDxrDumCaAaqCqb4PITEMibqYgRoKHjoDGboHPWWbACRLavccgCscsXaj/bH6kiS/7l6inBOk95qRxxGwbaGewQjNjfKBuMChehbp/vBnGJPlSIcTVXP2q+waY22WzvBiX4k8/qjsR1XObtI4fbtdd7H5MWPV8VatO1Rt43Db/B5Al+EJ9z0q3VzV4EgH2PK19LopGb66+r9ojGQptbvFK3zN8NQ1XsszccPttTqxgGWGdqF4wPQZNvXhHyl/8iU/d+yO3rMcMow5QxgxAETDJwZY5/eqTI35dA2N1ZXgfhH3WSfyPQiEmdTb2BHdUb3ntitxG0wi/L8MQP3sWe7YrFUX4O+C/NsArtIUZwd/3o38bwQ0ytFgQHkV1OQ8iwmQOUPGoH5mj0J2cZFkj0HfKlQAX2z1dzY=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc5dd2-01c4-4713-f0a8-08d828b4a08b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 11:45:52.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSS42lDRYQv1SEny9yaXRDs69+fn1baMT8peQQFl442gr4phb8uAmDdsM6088j/7pSyuXrMFCpV3TmNwXfWdlBxrHVYwbWAyI2bIGGZoCP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2042
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.07.20 13:36, Mark Brown wrote:
> On Wed, Jul 15, 2020 at 09:26:29AM +0200, Frieder Schrempf wrote:
>> On 14.07.20 21:29, Mark Brown wrote:
>>> On Tue, Jul 14, 2020 at 10:54:15AM +0200, Frieder Schrempf wrote:
> 
>>>> patch in our own tree, or if a node with a custom compatible string like for
>>>> example "kontron,user-spi" would be accepted upstream, without a matching
>>>> driver?
> 
>>> I'm having a hard time getting enthusiastic about it TBH - can you not
>>> just use spidev and live with the warning?
> 
>> Ok, I can do that, but when I resend my patches and add "compatible =
>> 'spidev'" to my DT I expect someone to complain again as my DT does not
>> describe the hardware.
> 
> That's the issue with kontron,user-spi too though :/

Yes, true.

> 
>> But for obvious reasons this can't be considered a good solution and it
>> seems somewhat disturbing that the maintainer needs to propose it because of
>> lack of proper solutions ;)
> 
> Hey, I proposed other solutions you didn't want to implement!

Right, but you have to admit that the other solutions turned out to be 
rather out of scope for someone like me who merely wants to use the 
spidev driver.

But I don't blame you. I'm now having a better idea of how things are 
(or aren't) supposed to look like. So thanks for your patience!
