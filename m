Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C11220E69
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgGONst (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 09:48:49 -0400
Received: from mail-vi1eur05on2130.outbound.protection.outlook.com ([40.107.21.130]:64321
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729086AbgGONss (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 09:48:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1GRJ2J7pzKUMnuOosha58oF8LzDH20q1zY5/3P8O+I2twfgeIFzKbn9kJZ48w1UIYyum2bP6eeurg0wzg9DH+IVVvoQtuSA0EVsI/xb397qKDC5Mr8Tim3bvFFxVhnMF0ZKbpttKJG4eI77XH0Su92N8eN8iPPhmnHAtcpzsn94UytYEGabU8+Eqi7LOGHwDlUQZsGjMgh30Xm71Imn1ujMJaeISW8wDFyuRW2d+ujIEn2jIlFW6ziLxO0jQdCsd4mKdjVFd0i23HmgoLYidv9P2Z32JMz7I2Rg+/d6G+Vf/2jeZLUkqoME4KQQkPMfxPnBEw9Fe94MTEzrnQWx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e8UJsablv1dxkbYP6E9K/fHukoA+a4FsyBwdsutfRQ=;
 b=ZwC+RuKRVuJNa3195E38wZCGJGj5j3/6ZgRQTo8h1jjL6rC6V6ZfOoObU3I4uBSOKO4fDb92b/8eW++v3IrI+oUNgMP02eNXBJ+28GIBTO9ym5wxWGewNv25OEI3594Zm2fstHpBH5YXnpwOwf6o3nWihtt5HMPzL8IMWz3HzHqIbH5hcfQAjsS+Y/sV/d8+d/UlQycDkjM0SBLG/XYRb/guT7AvM3B5LhrJaYCv0bAmyIFDmoMBr0SL3JW3t95BTsWLB2WvdtAsdYFjQb0/orB7B6+EErKoXmFG3h597CpOhVye2weCMzaaYeLiB0LPpHvMWMGXYGB808TBkjyH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e8UJsablv1dxkbYP6E9K/fHukoA+a4FsyBwdsutfRQ=;
 b=ZPFaDMRPBDGNleNbsGQEjUfRxEn5C95qfqscdtVCsy74WB3/Cm01J+54h8oJ4TEq7yiXNSnwxpjYXd3yRTk2CZaYsnATQJmXVrA5hmqWJ3gYsf/9P7wKm1TkojTiI8IxkjIi+SiwC+qjxPlyGd7ECzSYwiuG8LR+Vl/TzwZwQCM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB7PR10MB2345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 13:48:44 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 13:48:44 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
 <20200714192907.GJ4900@sirena.org.uk>
 <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
 <20200715113609.GD5431@sirena.org.uk>
 <824b8479-e204-d087-7887-a2dbefa0f844@kontron.de>
 <20200715131033.GF5431@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <ce532200-a18c-d618-7f73-6f6ac8f8522e@kontron.de>
Date:   Wed, 15 Jul 2020 15:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200715131033.GF5431@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::43) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (109.250.128.36) by AM0PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 13:48:43 +0000
X-Originating-IP: [109.250.128.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e81ba684-1de0-4747-5f92-08d828c5ca2a
X-MS-TrafficTypeDiagnostic: DB7PR10MB2345:
X-Microsoft-Antispam-PRVS: <DB7PR10MB2345A0D8E5B34CBB13628123E97E0@DB7PR10MB2345.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewUEpim71jP5GkL2QwwalAPJCMKkKi1glhUz7yIKVL6qvqUPuEl6gAFbaoJBAlqvGDgiEvOKEd1LlWcic5Zep2tWfyGFo5zTbCRMZFte+QqhMW8PKw6SihS6XaRFG2s6OFzqWho/MbzJMnAIlNuYT9oloNQDRYYXWJ/ZirGHdnXHquvqP8IBW7RXzqgcpXHMes6MDOoGySfh2uORRSb7/v5K2iNnOLM6nmQcc2sQNdNEFf3msJ+aAgLWkmZ5FQ1hV9Uqe51+5ZOGHpFL1jNSqSfCTDq56RdQJ/hB34T07Ka2agQXIUh/QKMQz6jJ+IZc8p622i/+ZmG+ZJh/4RkZ/vKieWii1Ioxit6aHiHiStIQjT2r7Rjg63d9xunjcbN6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(66946007)(186003)(16526019)(6486002)(53546011)(5660300002)(26005)(86362001)(31696002)(83380400001)(31686004)(478600001)(4326008)(2616005)(956004)(44832011)(6666004)(36756003)(8936002)(16576012)(52116002)(8676002)(6916009)(66476007)(66556008)(2906002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 44k2munNIh7pOvvzd8M1k6QGRKY765Ql4YXINWIsS8ALEtcSj0SwL2vsx96dPcIJ9I85LBISR4xW27/UHrMlP3brWxTI3q1iOvJUq9cnegny5cOeW3N4F9xfxi1375ojqFB0EtbH4kthwR9WOGljlJbzFb7b3U1QAT4snOqaT/uppX19dqAC9ZVw9I8hWBmmnYmnEMWDGQoB5fP7rv9sOoRlzy4W/YOvUjGkumxJzDsQH4ess/BhrRVUXxB1+Khl2P7CptxKFA/g3xv8+f6hMvcA4s2u8//J8GJNcWzwUwU++7fKcyuwXPu0TRUEkQB0JWPk2tzo5cKYl4Ahslkg4qjHTaF3RUleaDvAXI5SbFinV4Wby9x20MGVHeKSHVnjWm5mqbjuW8qSAltE+IQy4LbOOBkL0WyYUlCNh09LcLq2UxxEUXM0HQ3vU1pd+ToMjedV1+DDEHq5wguguajAoTiEWtWyE/cwP406pHlvgtU=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e81ba684-1de0-4747-5f92-08d828c5ca2a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 13:48:43.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL2Evqbld6WqR1X7p3JuA0WdPkcCCISwL9dC7LsCddtuGy3qQ/4S83m3IQK7rSLYyk4b9yOJOZ8uAtupRN2WWM4S8U1HHTqimInXdZD5bPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2345
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.07.20 15:10, Mark Brown wrote:
> On Wed, Jul 15, 2020 at 01:45:51PM +0200, Frieder Schrempf wrote:
>> On 15.07.20 13:36, Mark Brown wrote:
> 
>>> Hey, I proposed other solutions you didn't want to implement!
> 
>> Right, but you have to admit that the other solutions turned out to be
>> rather out of scope for someone like me who merely wants to use the spidev
>> driver.
> 
>> But I don't blame you. I'm now having a better idea of how things are (or
>> aren't) supposed to look like. So thanks for your patience!
> 
> I'm not sure platforms like this are a great fit for DT TBH - the
> trouble with DT is that it turns things into ABIs regardless of if it's
> really a finished thing, platform data based systems were a lot more
> flexible here.

I see your point. Still it seems like the overlays would provide a 
sufficient alternative in matters of flexibility. Raspberry Pi uses it 
for years, which made me assume that some generic loading API is 
available. But it seems like everything is RPi-specific and downstream.
