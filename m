Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488F83AC80
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2019 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfFIXuK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 9 Jun 2019 19:50:10 -0400
Received: from chill.innovation.ch ([216.218.245.220]:48998 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFIXuK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 9 Jun 2019 19:50:10 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 19:50:10 EDT
Date:   Sun, 9 Jun 2019 16:44:27 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 9AE26640134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1560123867;
        bh=ANHQkXMvHNXcU33vNeXl0bkJnCxtdn+016CmezBUMIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDgP2GehsA5TCdzYC+SZQsOwxy0QkTU27vMqeUB62ipzo1alidjlf1i9tl55dZabi
         KGPsKiYP3JoaNBW1iy+EKAKXMRkq+NtHeGIFI7qYkpPORJS8rsyef7fu8zmwTPJ4es
         IToByZJmMiYsdnmSnTQvFixf4XUeR6UGA/f2DnI4MXAlsS7QuLbp/R2ba6xDrVUs4z
         ++eSCviRnOoD7bDTPMNbobdebX4H/fKCvp45ux+bHV7ac0asnyH6EYRgswp9tYQVq9
         dtY8hgXrkcGPuPUD9MREyIeKQZVz7M0fsikt9yDM0qdzEoPGF3YbqxVL7OGVIYJ8oB
         U2c9NC/InOHMA==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Message-ID: <20190609234427.GA16597@innovation.ch>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:
> Currently, the ACPI enumeration that takes place when registering a
> SPI master only considers immediate child devices in the ACPI namespace,
> rather than checking the ResourceSource field in the SpiSerialBus()
> resource descriptor.
> 
> This is incorrect: SPI slaves could reside anywhere in the ACPI
> namespace, and so we should enumerate the entire namespace and look for
> any device that refers to the newly registered SPI master in its
> resource descriptor.
> 
> So refactor the existing code and use a lookup structure so that
> allocating the SPI device structure is deferred until we have identified
> the device as an actual child of the controller. This approach is
> loosely based on the way the I2C subsystem handles ACPI enumeration.
> 
> Note that Apple x86 hardware does not rely on SpiSerialBus() resources
> in _CRS but uses nested devices below the controller's device node in
> the ACPI namespace, with a special set of device properties. This means
> we have to take care to only parse those properties for device nodes
> that are direct children of the controller node.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-spi@vger.kernel.org
> Cc: broonie@kernel.org
> Cc: andy.shevchenko@gmail.com
> Cc: masahisa.kojima@linaro.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/spi/spi.c | 103 ++++++++++++++------
>  1 file changed, 72 insertions(+), 31 deletions(-)
[snip]

FYI, I tested this on a MacBook Pro where the (SPI) keyboard driver
depends on those special device properties, and verified this patch
doesn't break anything there.


  Cheers,

  Ronald

