Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392D33619D4
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 08:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhDPG1f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 02:27:35 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:50402 "EHLO
        20.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhDPG1e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 02:27:34 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2021 02:27:34 EDT
Received: from player758.ha.ovh.net (unknown [10.108.1.112])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id DEC1D285FB7
        for <linux-spi@vger.kernel.org>; Fri, 16 Apr 2021 08:21:30 +0200 (CEST)
Received: from RCM-web6.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 9A91C1D247E91;
        Fri, 16 Apr 2021 06:21:23 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 16 Apr 2021 08:21:23 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the
 json-schema
In-Reply-To: <6e5a2693-fc19-efce-5aaa-4712b0dcb802@gmail.com>
References: <20210415220201.16429-1-zajec5@gmail.com>
 <6e5a2693-fc19-efce-5aaa-4712b0dcb802@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <31b1f1659e2c356923cef9519a9116f4@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3236399283072175855
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudelgedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejffdufffgjefgvdeigedukefffeevheejueeikeehudeiudehvdeifeduteehieenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021-04-16 02:32, Florian Fainelli wrote:
> On 4/15/2021 3:02 PM, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> This helps validating DTS files.
>> 
>> Changes that require mentioning:
>> 1. reg-names
>>    "mspi_regs" and "bspi_regs" were renamed to "mspi" and "bspi" as 
>> that
>>    is what's used in DTS files and in Linux driver
>> 2. interrupt-names
>>    Names were reordered. "mspi_done" has to go first as it's always
>>    required.
>> 3. spi-rx-bus-width
>>    Property description was dropped as it's part of the
>>    spi-controller.yaml
>> 4. Examples:
>>    * flash0@0 was a duplicated node and got dropped
>>    * regs and interrupts were formatted and reordered to match yaml
>>    * <0x1c> was replaced with <&gic>
>> 
>> This rewritten binding validates cleanly using the  
>> "dt_binding_check".
>> Some Linux stored DTS files will require reordering regs and 
>> interrupts
>> to make dtbs_check happy.
>> 
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> Thanks a lot for doing that, do you mind adding Kamal as a maintainer
> for that binding if you have to send a v2?

I wasn't sure if I can just add someone else like that. He's already
maintainer according to the MAINTAINERS though, so I guess I'm safe to
do that. Sending V2.
