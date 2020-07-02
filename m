Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175FE212945
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGBQYz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 12:24:55 -0400
Received: from mail-eopbgr00127.outbound.protection.outlook.com ([40.107.0.127]:50144
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgGBQYy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 12:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/2DOFO4MU63m2Pa/dZesrp5ERlc6ilm9SmE+BPU55ZOPZguPPDOA4xeRCgV0A6oH1cvy26L7mb2Uek4Xqkba3onCdfSluyfY/FnBDwZPEuVvHljaT83Q1cRnr23bOKI7qcOi2uTvnvZdZVOsKH5EHO+Z4Dlps5YgDy5/ZB6wt6N65Y2q3io7MTDqHAf9K5yRK9Lsi/gCp1uJqKWZHvM3kSR11CUfy+NGnauVyz6OyCp2254lBebuJOkHjnbU5qB1dth52MIPG42OYkj8t1hljEhE3EyPdr6yDbGMs/TE8krHMnCpYynVOJsAUy0ueIuo+fByednHp+RRHRwTQOSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9t/qY35iaqlwM+X+tvR9OnlDdtq6AJAsJHDrdfTgEU=;
 b=GoTrwBtM/356qqrHBv5F0GkatUpt1zMBL3gvIkxLKEjd68dM4w9ljAKA/tE5SVYIXrtNHtd4I8HOIcAXYU43q6E8LvmlKXIHrobZ2jEZ/mcFYlndOnHvOduSHC2hlVin8560d5m6YgimbWfsrACyb/AzpAk2X4Yhj//MKCa+rtcPI6DnxorU+q5D0YiGVjclozs8w1cJ/FXTx7PMqq4TCwV+GNzTmNkii6mY72ePvvevNIG5LbvalArrvLwkFujUX6MSc0FzdvSsfq+aD1Z1Zwb3mbSUE/g2pDblKwzjjr0b7LRQTGaakn+bBXkeuw3tlyg58a5M2DgZA68nnAaWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9t/qY35iaqlwM+X+tvR9OnlDdtq6AJAsJHDrdfTgEU=;
 b=kVvo4HhqiDDStB2Gl2hf4jUE8eBaPMdHDj8tygskm6b1ww6++mhAVAethKBq24eDCBalnQaKOnyaroK5gvVpmDVfRuXy000IW9Trbq0egP/5/KBrItYb1IorUtsAQgbQtilmMQsL2L9JsYknvwlBPPOwc3mMxw042BB/TO3WQvg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB6PR1001MB1270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 16:24:51 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 16:24:51 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
Date:   Thu, 2 Jul 2020 18:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200702150725.GI4483@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (46.142.79.231) by AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 16:24:50 +0000
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89ec78df-b412-4c86-25fa-08d81ea47228
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1270:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1270B30EF4DBEA4BCE7DCE17E96D0@DB6PR1001MB1270.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igYvEfEnoZp1/roTJLH12wDqeo/ojOUZwB4Qx2HRZV5u35ZGM80tlaSmlGFg5eiWfH/cPV1LgDyAf45bK3YLk0OU2ZQL9FPR3KEgYpsrJ8vhJDfsJA20V1NIs8540QslJ25lIpDrtedXxk8m/j4wAnu3S93VaoKpkv/CFStX3JPz7fUqDklYRRdm+4vFZ5iSX5fsjz2rX3PH5NQG0Cliq8RT4BkMXVQ91a4ccIpS/eWjpj1x0SjtsZiTIK94xo1DD60XJCpcE7PuSsKUCvhDeZljaQESUqVQpzyBYCZHT4YkOxIMQEhlajFZ1tldHM99SD6FBna5MLmBazytdVHbBpOVxB4YBgVLHabb/blc5UwdkYQBwaEwh7OBMYf1xrlg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(39850400004)(136003)(396003)(186003)(66946007)(316002)(16576012)(2906002)(6916009)(86362001)(478600001)(36756003)(8676002)(31686004)(8936002)(5660300002)(4744005)(16526019)(6486002)(66476007)(66556008)(4326008)(26005)(31696002)(44832011)(52116002)(956004)(2616005)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zetbi8Vflz7DmCpGLAgOrW4QRaaETgCvE6H8LQs/In4jA1nj0F5knsVCIqprXri7pefyOi7VBvuPxussoY+nOtJ6em+m4kFuJTsuvi5TBKIRMI25U2OG/XIiOb8SF8AYY467XlDasqaKJfgL0OPkIW3IL8pwRYBACl3XL3dp9tF4I4QF9zZNxyiUgPHn6DzRrvisYPgVdRhGOAOnTGl1Kbs2cPeP/JocJLd1ZcTVtaOz8VJc3yty6YJibgm8WWEUwlo0nfGE0WAz4iVjeTuc3TxsL/eWeJ2tNeqjUbM6YfZvimgtm1Qj/BSDi9JwRFtz/tpIF5RztunWFuX1uXI13BeBPRJ/KpCm73348XOC0qnpwpSwwCiw+bSGRkK1FR0I5qX5YZh1HK/oZkHR7QDvYgy8SSnURpxi+NsfUlfKUJhd2W5Td2xXc9UCBHifON7CTf7v6Qg44u1eHwry/qsZz/s872hO68/rRSaucPVlShs=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ec78df-b412-4c86-25fa-08d81ea47228
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 16:24:51.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQ+2wJDXYfKsve7RefW2JncLAoiu0esZP0yMLFBFxvH9L6XWGccHZwxCoEcirUMxLzlRgGim0gYES2xaX1UCcy1o3BWMLcwkhLBBqJEnGe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1270
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02.07.20 17:07, Mark Brown wrote:
> On Thu, Jul 02, 2020 at 04:46:09PM +0200, Frieder Schrempf wrote:
> 
>> My intention is to use the spidev driver in the default board DT for an
>> interface that is routed to an extension connector and has no dedicated
>> slave device attached onboard. So users can attach sensors, etc. with
>> userspace drivers without touching the kernel or DT.
> 
> The expected way of doing this is to describe whatever was attached via
> DT when it's attached - the device is what has the compatible, not some
> connector in the middle of the connection.  The way you've got things
> set up if the device has a driver then they won't be able to instantiate
> the driver.

Ok thanks, got it. I will remove the spi device from the board DT and 
use an overlay if required. Now I got a reason to learn writing DT 
overlays ;)
