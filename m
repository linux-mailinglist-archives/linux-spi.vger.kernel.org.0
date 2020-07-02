Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638122128E4
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 18:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGBQEK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 12:04:10 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com ([40.107.5.107]:3332
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbgGBQEK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 12:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/GG+y56YnlTh9zvZDbT1CKaJUhSmbshWkgzqnOe5aibjTQC97tB63VtQmgEts7gGEzrDseIinLH6mrrBF5JrdXX5rXLIl4PqJz2WZ6Tt45i1G7b8cXkAwB7LBXmnfOlJjEt8wCasVTbVFhlr+VKkkEej/gNy1hLqUe2TiBEHqmbhwk/1kTNfxXKVLe0V+p7UqjqTCut4BWeCKLARUi6CrOBhgjMASQdGAjf0fty70prVqnhffSgboh5uSRWoQRqbkfjJFhPOPiB6OTH6s4ywNJ6/5fDVJyRCWFyiA6L7O+Ni6JOkMxoG9q984XpoSsSh5LJaEjlGT2znX8tPjfAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSde0tYRDQoxkqvgC1/C1yJuS0yknB/Sw44Vrk9+QEQ=;
 b=AsFHvMW3iDxjWqwrrf6hJp//bj5NGgFzfX29Mqu75OcqkIiTYxWiCrJlUD2xMPh8sjo+9dKAaXL9WzxTajYDQtZl+DCodgF8uoFsM07jjgDqxR7hyx2EWKqv9hprR0zG6rNISOCAxsbNK+ye9TE5wZinX9dE80QhVRw6oGOYTYleBMcCGUFoJERipfRA0yyjLzVPE0sZXRc0xkcrXDKO3y9pqwKgrqhNCbbfIfQPGT3GX9amU4sf3T3PCwz9P8hy06Reg+y2UGWBwSI4ZMpQglE6thtNKoWadZxX4jwqBJmaXzUkVbbRviVMJ3mFis4fFbic6ZehxIXSf43m/i05IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSde0tYRDQoxkqvgC1/C1yJuS0yknB/Sw44Vrk9+QEQ=;
 b=jAQg9GQO7ho3WWjNKTlaxTlPbrYDCLDJs5oh6wyTQcMfbaTulMMZYOZk65wABkVR65YqXH1rB853yff+y19gJOBDWHzgmWxJPLq7yavHKwKt/irC0jYxI/bTkzyu4lVNKAOOTnnkRgbeUHodS+iqWtiWLAm55XuQ3wMcPCnhtiw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 16:04:06 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 16:04:06 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <CAMuHMdUkHxOqqX95R5BEET-aSF5SYw2zufnxWuqmKnSY0NENcQ@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <992ccb30-3f82-4649-acc4-442cb2568eea@kontron.de>
Date:   Thu, 2 Jul 2020 18:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAMuHMdUkHxOqqX95R5BEET-aSF5SYw2zufnxWuqmKnSY0NENcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0143.eurprd05.prod.outlook.com
 (2603:10a6:207:3::21) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (46.142.79.231) by AM3PR05CA0143.eurprd05.prod.outlook.com (2603:10a6:207:3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 16:04:06 +0000
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90448902-d011-4fdb-e897-08d81ea18c3f
X-MS-TrafficTypeDiagnostic: DB8PR10MB3657:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3657A7777451AFE8C6CB4257E96D0@DB8PR10MB3657.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1wWlO7Vsqr/ZrG3KkGFZr48CA8TGZ1Y2w5joTV6mW0Cs+iNvjBcZ/waFhvzyUw6658190xihFulMTXpNJWBJ5ZATy4KN+xQ8nkyaMGlQM85GHw4Ri/j32HWklBMoeurxGmXgZT7FudZ9aFIm4yFpWLiRorIShQXHpA+PrOZ2CWxg3l06LpEW7VZTctDze46WE99xhlVUyvswNI1pPbfSjpckUW/jNivYc0+mgbxAkt4DGDrLEBam2r3QZYgM2JWSzVJUHtvdjOZWuRfPqwZRFsF7beYIvpL9+zdagCNELePcX68RIPNGkpWwZcMwquVvF/bKjswDcabdjBiYabVAZNWOW/a/43e8pSZRxh4AGuM1xc3UeH9DIEefqRqWZkifflzK/PUjP2PbMci9JALRBPinqcEDcJfyeMjp/fWj6UHriRZfWOzZVwhP/ycU6gNmj5R4N7L3gVpNp2NC0c1Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(366004)(346002)(396003)(136003)(376002)(4326008)(6916009)(8676002)(31686004)(2616005)(956004)(966005)(54906003)(44832011)(52116002)(16526019)(45080400002)(36756003)(8936002)(16576012)(6486002)(186003)(31696002)(26005)(478600001)(66556008)(5660300002)(53546011)(2906002)(316002)(66476007)(66946007)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XDWLW1zMHbHWjWqYQ0Vc25ZRrt1Ezm898GrfwuYs3a8kv3z9q/ZilKKjWkNVVJnt2PP40iPmYFZJLu/SPSFR/yDUQUjt/X9jc0UPJsXq/q3IG1dwsL+U+bV7eFe19OqKmE2BPzIuVSBnQx2osW22ImTqpCICp7/LMvoBLW/6x0yCPMbrW1l1lrG0Ov1TmUNgI67GWLl4+pVLItKz1mxTgK7PiOgxSkdErrnYGuuiybGUF83hJlFBmxJKi37wrGxrakRY4XlEhtPhZiD1wetUlXU1yyTObqStOhVGX5OVMFgGcFGSrQB8PDEF2ql16ZSWax042vVSW9mOfN1heYX3HFmy/8GKm6sh+e5ia98pdDMLpNVbjhzI8KkXOaX7e+i/v85lHJImVqeYTxAbCvImjg1nzH4HjO1UrF9A+5sgdUpdZBQDazuLkjrD+sT45FwKhlPqQ9FcBEttdFemTNIVn9kGnp0et4EoTDLZSmRafEI=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 90448902-d011-4fdb-e897-08d81ea18c3f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 16:04:06.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU0gY/STWY8hq583xD5yO5xGj/nRIWqH9GEcpoWuLoaYVyjsy5b2pmIT7iNmYHo28HCd2QHJR5MXcdbGEbxETcvGkDgPcx3OArp+6WLtyU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3657
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

On 02.07.20 16:57, Geert Uytterhoeven wrote:
> Hi Frieder,
> 
> On Thu, Jul 2, 2020 at 4:46 PM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>> On 02.07.20 16:25, Mark Brown wrote:
>>> On Thu, Jul 02, 2020 at 04:18:46PM +0200, Schrempf Frieder wrote:
>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>> Allow external SPI ports on Kontron boards to use the spidev driver.
>>>
>>> I'd have expected this to require loading a DT overlay for whatever's
>>> attached?
>>
>> My intention is to use the spidev driver in the default board DT for an
>> interface that is routed to an extension connector and has no dedicated
>> slave device attached onboard. So users can attach sensors, etc. with
>> userspace drivers without touching the kernel or DT.
>>
>> See https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11639075%2F&amp;data=02%7C01%7Cfrieder.schrempf%40kontron.de%7C5ca9f0ba0ccb4ab0329f08d81e983d4e%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637292987071583819&amp;sdata=M8y9HYICQLocSgRmak6uYsx9Y%2FoukaqgmK2D0F%2FTV98%3D&amp;reserved=0 for the boards DT.
> 
> You can bind "kontron,user-spi" devices to spidev from userspace:
> [PATCH v2 0/3] device tree spidev solution - driver_override for SPI
> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fspinics.net%2Flists%2Flinux-spi%2Fmsg13951.html&amp;data=02%7C01%7Cfrieder.schrempf%40kontron.de%7C5ca9f0ba0ccb4ab0329f08d81e983d4e%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637292987071583819&amp;sdata=D9pum1oTXWSt%2BY8Egb1J4DOgSa5KH3RwxsSmUl7LgUk%3D&amp;reserved=0

Thanks for pointing that out. I didn't know that this is possible.
I just tried like below it and it works like a charm:

 > echo "spidev" > 
/sys/devices/platform/soc@0/30800000.bus/30840000.spi/spi_master/spi2/spi2.0/driver_override
 > echo "spi2.0" > /sys/bus/spi/drivers/spidev/bind

Thanks,
Frieder
