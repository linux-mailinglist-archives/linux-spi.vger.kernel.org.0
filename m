Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FFA1EF98B
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFENq5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 09:46:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgFENq5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 09:46:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E77131B;
        Fri,  5 Jun 2020 06:46:56 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E0C83F305;
        Fri,  5 Jun 2020 06:46:53 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Mark Brown <broonie@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        lukas@wunner.de,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
Date:   Fri, 5 Jun 2020 14:46:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605132037.GF5413@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020-06-05 14:20, Mark Brown wrote:
> On Fri, Jun 05, 2020 at 12:34:36PM +0100, Robin Murphy wrote:
>> On 2020-06-04 22:28, Florian Fainelli wrote:
> 
>>> For the BCM2835 case which is deemed performance critical, we would like
>>> to continue using an interrupt handler which does not have the extra
>>> comparison on BCM2835_SPI_CS_INTR.
> 
>> FWIW, if I'm reading the patch correctly, then with sensible codegen that
>> "overhead" should amount to a bit test on a live register plus a not-taken
>> conditional branch - according to the 1176 TRM that should add up to a
>> whopping 2 cycles. If that's really significant then I'd have to wonder
>> whether you want to be at the mercy of the whole generic IRQ stack at all,
>> and should perhaps consider using FIQ instead.
> 
> Yes, and indeed the compiler does seem to manage that.  It *is* non-zero
> overhead though.

True, but so's the existing level of pointer-chasing indirection that 
with some straightforward refactoring could be taken right out of the 
critical path and confined to just the conditional complete() call. 
That's the kind of thing leaving me unconvinced that this is code where 
every single cycle counts ;)

Robin.
