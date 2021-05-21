Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F338C9C3
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhEUPJ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 11:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232206AbhEUPJ3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 11:09:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79947613AF;
        Fri, 21 May 2021 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621609686;
        bh=7ykpPg7h0iFlH71bVYS2r53l+t1SGzyOmhVqCVEl/ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I34qb25lW8m1aKnm/TsBBTUvPks6ZLbZ6HzqiAGBpvadRDjMO+2Ru6wRQudY7Jcoc
         VlXiwoj4XT5e+kI2sYA7Ydtf8KV9Sfpis4X0arUxnEXn/+YGPJ9/1C5SiWxeavmVFP
         nsap1VO13oW9zlZpKdGPsqp4PN2ZolqZyfHiGw+/Mt8Rtv9vF3wJPI6ypWQD3lz98v
         xDAljXvkkkMlWWwHsAqsHiMxNg/zLmG0bLF69gi1rDQLQ7CK9ZX/c8WYy3I+hcMytU
         0H/QtmFFu62tQLaA20SO4ja1lE2nCY+b8aJIXmNHuQgqi72ciGgpXU6GUsXPnCsXhv
         exN53HMmTqRiw==
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v1 0/2] Export the spi-sc18is602's max transfer len limit to SPI slave drivers
Date:   Fri, 21 May 2021 16:07:59 +0100
Message-Id: <162160967729.10785.5397629735840128841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520131238.2903024-1-olteanv@gmail.com>
References: <20210520131238.2903024-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 May 2021 16:12:36 +0300, Vladimir Oltean wrote:
> These 2 patches make it possible for a SPI device driver which uses
> large transfer sizes (256 bytes) to limit itself to the maximum length
> supported by the spi-sc18is602 hardware.
> 
> Tested with 200 byte buffers on the SC18IS602B.
> 
> Vladimir Oltean (2):
>   spi: sc18is602: don't consider the chip select byte in
>     sc18is602_check_transfer
>   spi: sc18is602: implement .max_{transfer,message}_size() for the
>     controller
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: sc18is602: don't consider the chip select byte in sc18is602_check_transfer
      commit: bda7db1d952c3ff7c24c11bc295aa72aaeb98451
[2/2] spi: sc18is602: implement .max_{transfer,message}_size() for the controller
      commit: b4e46c9954ad55092502e1e8c44ceb9b6744bade

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
