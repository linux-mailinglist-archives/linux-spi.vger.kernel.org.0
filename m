Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24CB21D6A0
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgGMNT7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 09:19:59 -0400
Received: from mail-eopbgr140101.outbound.protection.outlook.com ([40.107.14.101]:19173
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729814AbgGMNT7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Jul 2020 09:19:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB4v5ikKsYXNPDo/VC+RFUiHeC9zezsUyhKFVFolCh47gZj1Ex7ZIYuWiCfHN0z9PyV+AhxmFA1p7Il+1i8J9quFeMa+yBL3nUT1sjwkylI96ZeMkFabwwHVWPIzs92oygJ6JGNixTxm9Waux/iy8v5HT+oCctsLrMD+zACOBYgahC7JgKVBowPh6RR4ncLtk3mgQocsU130vNYP+X2rVOPvMkHRC/la/iPvn/r13sDZTYUAmxsjF8vDJXnWXmO5lJpZcrN0R6zw0Ia6FL516Ns0qmZoa3pJVYzdvsD6vmRhysuUSEjgcOwZ/54i8g/68bAvZgF47DeikYgyeYzFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIKTvy+NhqUB5W0dktBjPgA/SdGwJAEA+bkVmS1FTYc=;
 b=Dga670LqJbhJWb/WTX7rmYoibA9zJ8YEhUvz//kEWOEAV+UtaVtzV5BhhUlaeAJKSefcLQeAUpW77O5kRM+XWplN9b8h1LQxDWH4bkQNj1jaEvOuNXNmnDYY1MkJ+fEGTyD/o7c1249vvTm+kNv5BzgZOdW0o3CuP2OFXjsSH/GCZ+khBwMp1/s3btgZ+ao5TqIW7TcwxOpKhfRl+J2PyKdPUlTzNMrNB+ohQbm1TkHYHbSGSgcT7Ocjrya4TjhpEXre6Xlwg1Ay9Hfc/XQtDcsbWdkhDB1iov6sGLloXPYb9S1NiM7ko3I9OD3bDRp2vka2ylWlN0u9k4pMybYcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIKTvy+NhqUB5W0dktBjPgA/SdGwJAEA+bkVmS1FTYc=;
 b=br9fqrMu/eith2wlPfTpF+OSGovi2MKQLceoWMTvioFSPvO8o+M0G3/O83W7MGyxYUT3OmpYufORaoE/vGCE1szoyo/BrXSmTcy5r0t1eKwtCxf0GIadBu4Gg30Qn97nNLK5tqrtLmt0xfbkHhfB53swVwdqXS4lP9Wf8I3EPAM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB6PR1001MB0984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 13:19:54 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 13:19:53 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
Message-ID: <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
Date:   Mon, 13 Jul 2020 15:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0026.eurprd03.prod.outlook.com
 (2603:10a6:205:2::39) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.63] (80.147.118.32) by AM4PR0302CA0026.eurprd03.prod.outlook.com (2603:10a6:205:2::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 13:19:53 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c98e00ed-b0e0-4f64-3b94-08d8272f6dd5
X-MS-TrafficTypeDiagnostic: DB6PR1001MB0984:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB098492ED68046B11BAC50AFDE9600@DB6PR1001MB0984.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izWDS/FkFPwybbLOskSV8dPne9Ng2zJUw6LL3EwhQr7w+sGi1Os3WbnIVtnyszfpK5hkiTqMd0s/MBUviE4m89G8uOyeftQABP1GQz/o+LgIfj2gYgaqTsw3RQhl8OKMYJroZtriFLPyKnPbq3QUrQpeV5eKwgUXEXPJ8Vk8lKYtC2LLNIC8e75BYgZS1C2Ak1gY5CeYoUitOCNL5c6gUQreJlL1uYO2sOa/E2+COfaKyT375gLQFYrlpaXbcAcrKCgoLAf3G/GxDmE1mNqEKHbxrimzC9ojPGg5yV0+qxS98tM/TuRKqYOHdFxoVazPvsN97U2sD7h1Zm9aI8PbsnuQr8OoI1Vb0PLHUfYabx9DX5EIT8EMYAM/HTJF40fb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(26005)(6486002)(52116002)(8936002)(16526019)(316002)(44832011)(956004)(2616005)(186003)(53546011)(2906002)(6916009)(478600001)(31696002)(66556008)(66476007)(86362001)(31686004)(8676002)(5660300002)(4326008)(16576012)(66946007)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6cBgWiikmYHkHQ8HZW2MDRwr5RGC+fHIeYU21uWIPTgGC6nJu4QJSLlzpd6GZi1qyk5YmBoP2mLP7ylqJ3CubJPMiOATZFq1ujPZWATPqbGUhq7RApNUCDcedZh7Y0AyPgDbabvp9WNwi6KryIrp0MzxdF/1iSfBty5fKTHfqiaFCjv6R9LyRYpLJwy2dUvImUmlsGwHTPepDh9vastkNsfURSsyuJzmVMQPqCGN1En+lUpHvhwcI6ukw/GyIjNJ098y62Z0Kz/oJ7+F6bu8GJAlqpsnVKAb7u3tTZQIdDKoGpBjZdhXSvYQCh/oPl0+zOdhup7Ovf4U6VWGRWgmCHO2/tDr+kODOCKhLQxEZ+IiH7jDhp8UnziddLiKP8xkOHsoqbLuAUxcW/xC1dI6mpVlTqf6dm937oyYbwyF2u61pj3nPnN19Hf1swbpR0u55LdMMVsyvDUOQkRJ/oyWiVrXQPZ8rFFhj/ghS6gsha8=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e00ed-b0e0-4f64-3b94-08d8272f6dd5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 13:19:53.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HeLfehjjuj+hwpIPBKT2EHQQuF04LFPTT1vhM8vZnRmfQvtCFSmMqvC8fK/wwR0Fu32lgdHfBwDTvLsAkrvmU7DngcaHrHL9zviT5fyG9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB0984
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02.07.20 18:24, Frieder Schrempf wrote:
> On 02.07.20 17:07, Mark Brown wrote:
>> On Thu, Jul 02, 2020 at 04:46:09PM +0200, Frieder Schrempf wrote:
>>
>>> My intention is to use the spidev driver in the default board DT for an
>>> interface that is routed to an extension connector and has no dedicated
>>> slave device attached onboard. So users can attach sensors, etc. with
>>> userspace drivers without touching the kernel or DT.
>>
>> The expected way of doing this is to describe whatever was attached via
>> DT when it's attached - the device is what has the compatible, not some
>> connector in the middle of the connection.  The way you've got things
>> set up if the device has a driver then they won't be able to instantiate
>> the driver.
> 
> Ok thanks, got it. I will remove the spi device from the board DT and 
> use an overlay if required. Now I got a reason to learn writing DT 
> overlays ;)

I need to come back to this for another question. I would very much like 
to do it the way Mark described it above: Use a DT overlay to describe 
the device and load this overlay when the device is attached.

But if I get this correctly it requires me to write a specific driver 
that handles the loading of the overlay, which is way too much overhead 
for the simple issue I'm trying to solve.

I would have expected that there is some kind of existing userspace API 
to load an overlay manually, but it seems like there isn't!?

So what's the reasoning behind this? How can I solve this in a 
mainline-compliant way, meaning without either keeping downstream 
patches to bind spidev to my device or writing and maintaining code that 
does the overlay loading?
