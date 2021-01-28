Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92D7307984
	for <lists+linux-spi@lfdr.de>; Thu, 28 Jan 2021 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhA1PUW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Jan 2021 10:20:22 -0500
Received: from foss.arm.com ([217.140.110.172]:34228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhA1PUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Jan 2021 10:20:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DE81396;
        Thu, 28 Jan 2021 07:19:24 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7E813F7C3;
        Thu, 28 Jan 2021 07:19:23 -0800 (PST)
Subject: Re: SPI lock-up with zero-length transfers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <CAMEGJJ2M+XErpt8LNuRbpDuFDPBg_kwPsmU8P0aGAtO27-xw6g@mail.gmail.com>
 <9916bdb638880bcd1dd4ba5d473fe704d4aceb04.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fd5f3176-d0f9-54c9-5490-907f6af515e4@arm.com>
Date:   Thu, 28 Jan 2021 15:19:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9916bdb638880bcd1dd4ba5d473fe704d4aceb04.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021-01-28 14:33, Nicolas Saenz Julienne wrote:
> On Thu, 2021-01-28 at 14:26 +0000, Phil Elwell wrote:
>> Hi,
>>
>> Commit [1] - an optimisation of the PIO transfers loops of spi-bcm2835
>> - causes lockups if a zero-length transfer is attempted. The commit
>> message says that "[t]he blind and counted loops are always called
>> with nonzero count", which is technically true but ignores the fact
>> that count can be reduced to zero before entering the loop if tfr->len
>> is zero.
>>
>> A workaround has been added in the raspberrypi/linux repo that
>> explicitly checks for zero-length transfers in
>> bcm2835_spi_transfer_one, but perhaps it would be better to catch this
>> degenerate case in the common framework code - I'm not an SPI expert.
> 
> Me neither to be honest, but I'll have a look at it. Thanks for the heads-up.

Oops, sorry - I suppose I assumed that zero-length requests make little 
enough sense that they wouldn't be a thing; I also have no practical 
experience with the SPI subsystem.

FWIW those patches were only ever meant as an illustrations of "things 
that already have far, far more impact than an extra bit test and 
conditional return would" from a codegen PoV, and they did come with the 
caveat that I had no means of testing them :)

Cheers,
Robin.
