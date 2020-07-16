Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB651221DAD
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgGPHx7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 03:53:59 -0400
Received: from mail-db8eur05on2112.outbound.protection.outlook.com ([40.107.20.112]:45921
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPHx7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 03:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qchx4G74exwy7lWkl1YTo8ZapkX0L/JJxQd4hRKPzE4T0D1Jmc9urkKGuiNb/xPcWrKMYrFqPhek43OJWS6LxpvbejIv0Js8OLgshVLqOY9ZjF1TzetCttm2xxzSt6OW6nmpr7cbSmwL6SsWK/BgHbkn8PRgUFeNVyBCq+Gn2UeKcrSIcmKtKDJP+tzUXuGCUZHm6MNMOzR3sfNl/wbWkPIwrgH5C6F5SzUs/zfktPo47QYFoTKq37achycwjfM+mT17SZd1CaUbPVbHWXIZznYwwFuqobpkJyxBQJ4VBaU52uxdpLLR5JgI9Vee8DMzn+Ygd4cE7JjYQKQLfJTuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/8i5LAn7x00cZrKzO/mucrlqeBd6NDdcbAzQ9lrWGo=;
 b=JL6d3AzeDh8vyb9Hmklu9WfEAtpj+NiC1+ddIxB1ysxYV6vsEwY2vxVRFCje1/xEVWDLrc+aKZHrDQWxqnkjcepD4NkVJI1+nUdDOEq/F/BPBVOckafgF4B7RHNhrhtgx4D5cVzToxxjTxv5LuA5qtfD0pqdc+mshpIVyRJnUHDr2qfD/mpumc7uChz3FTvVxd3ESwjaakXfVw9MfGff7ucFRuunWi6PKy2kXY+THOGQS6WThZkIpEUboZNRoSDn7czgYlPd0NUHjd3zY3gc6xveWnrwgRX4YPlduYkDfiZahmg14Fwr6JTUfCxt/DEU6PraAnZeX8EGztDR/UIK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/8i5LAn7x00cZrKzO/mucrlqeBd6NDdcbAzQ9lrWGo=;
 b=ozsaJuGTqd+C/2or8RPHs2UcuU0uFPrTbkfnyb9RdnBAfPh8myjAGXSIbFZzyilxLOt9m0R7hxKJmeeb+0LA18YUFtHL+AJPQyakoSFFC+7HtzwSqA8PVBShWm/2JCM4LqmxDWXE/jks7OWgt80QZZwMY5vfWBdrtg5Zq671N1M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB6PR1001MB1365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 07:53:51 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.027; Thu, 16 Jul 2020
 07:53:51 +0000
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <CAMuHMdUYnMkobQBVLWkL-n8HLHGVOTqDs7H7kaYN6gPQmV_A7A@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <7e2e0a65-d67a-f839-0a25-cee7f883ee6c@kontron.de>
Date:   Thu, 16 Jul 2020 09:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAMuHMdUYnMkobQBVLWkL-n8HLHGVOTqDs7H7kaYN6gPQmV_A7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0011.eurprd03.prod.outlook.com
 (2603:10a6:208:14::24) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (88.130.73.71) by AM0PR03CA0011.eurprd03.prod.outlook.com (2603:10a6:208:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 07:53:50 +0000
X-Originating-IP: [88.130.73.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcace062-ceae-43b5-bfc8-08d8295d611e
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1365:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB13658BA141236E7AAD47FC5BE97F0@DB6PR1001MB1365.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELTods9JZEnwRcvwjxQ6MmAZUr0oR48ba+lej56hs+cN9E56UySdM5EBVXt2mWdUBbQKH22KLlCbrBss+Yy+KvcOWL7A8P0OSH1i2LLk96XhlUfK33EAB6xDizgJ5XKdjsetCmTzeVoedvtrzw5/yyZiPOdf8oEtdZn3+qI+wP/VhFmYo09wZo6HrT8uYzBX9zt0+hHyPthOYxnPpiJS8nDFBOmnS+MGzK2z8mMvFSd9UsUVW/UlHcGfD5N/v7OuZJxYk8jtFlwTcZ0GZErH5GxH4ggraPS86SJSPKZQZAycm+Anzy4UtwvWeC44d3OS0NLO068g//Ml+FWo7hStgeoS37QyPLoiY4efpkX4FAeahQgKcMy5A2I6DA8b/QEKYbtFAmKNbKNoIFlAj++1JkKZjpzwCNpIdJj3pbIs59fqeXFh4fdVC4smcGDwJM1kQbpmwOduhu/CUzNG1xvTVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(36756003)(54906003)(110136005)(86362001)(2906002)(6486002)(4326008)(31696002)(16576012)(66476007)(66946007)(316002)(66556008)(478600001)(44832011)(186003)(8676002)(53546011)(956004)(2616005)(31686004)(966005)(16526019)(8936002)(26005)(5660300002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KlTLfnlBvi0fh6ET7nc1iaF1Cwl5W3RsCMPQWocZf3aB8NytC+fKQuAxuiqBVxGRmx54jGSx++e0KrIxpXp7R3NjxAvo08jH7I3upGNPMloFuxuxgxVeUOWgjDlxZhnxtBP8300RrDtuAmGl6g9Ms5feco5k3kjh3AkawsLSWuzNDLtFwX0OzPPzi8xUDz7sXMZyaGEm/2/1smRbUVXaNjyfZh0t2qEcWdJzPST79K3wTtx7m/PDlnx7v0Oru+kWCYF9WXle4y+Uxw2fpo7+5ywhIHInbIgxw1Lm19bAgeYoHijPbyiCm1odHQYClohihz9XH3kdDBmjGnH4NnjsZguuUlBG+cA6RXiJiinaE+9i3Av2RNW35pXv0AozeHhfFyHFfyVqETrdOfO+35Vn6HMNgZ/yZg6hnDkKQBAFLuC8G3C3w6nxyG9U0wUr1opnGuGdIhk2SEtgdThYLnkF9uhKHP7iWB5mUA7EXy6C/RI=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bcace062-ceae-43b5-bfc8-08d8295d611e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 07:53:51.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH8PzcCmw3zMro7bXZaWQaNQukL1RLVjcRyCV+IqR2NISuJCwI0mJI8qtjetQU5z51g822vp16yNgg7UQbuJBh+96ifJAvjUjzDJdNNJzic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1365
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.07.20 21:06, Geert Uytterhoeven wrote:
> On Mon, Jul 13, 2020 at 5:11 PM Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jul 13, 2020 at 03:19:52PM +0200, Frieder Schrempf wrote:
>>> I would have expected that there is some kind of existing userspace API to
>>> load an overlay manually, but it seems like there isn't!?
>>
>>> So what's the reasoning behind this? How can I solve this in a
>>> mainline-compliant way, meaning without either keeping downstream patches to
>>> bind spidev to my device or writing and maintaining code that does the
>>> overlay loading?
>>
>> Basically the reasoning is that nobody's done it rather than any grand
> 
> Nah, it's been done, but a bit unsafe, if you don't know what you're doing
> ("with great power come great responsibilities").
> 
> Please check out https://elinux.org/R-Car/DT-Overlays
> I do my best to keep topic/overlays branch up-to-date, and working.

Thanks! That looks like what I was searching for, but couldn't find it. 
So there's some work being done. That's good to know. We probably can't 
use it in this state, but that's still a lot better than nothing.

> 
>> design not to do it.  There's some issues for more complex connectors
>> present on multiple boards with mapping the same connector onto multiple
>> boards where a resource on the connector might be provided by different
>> things on the base board so it's not quite as trivial for them as it
>> should be.
> 
> There's a big list of issues at
> https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
> In other words: more work to be done, to polish it, and make it safe(r).

I'm now getting a rough idea about the efforts and issues behind this, 
thanks.
