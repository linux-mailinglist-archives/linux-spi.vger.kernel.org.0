Return-Path: <linux-spi+bounces-112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F04A8007C7
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 10:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F353CB211B1
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201D1C6A9;
	Fri,  1 Dec 2023 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN6G/Cmk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94D200D5;
	Fri,  1 Dec 2023 09:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37BAC433C9;
	Fri,  1 Dec 2023 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701424661;
	bh=ccXiUANYmPCB8NhMfkOx6I/A0dGnOoIhG/1n4IleSEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nN6G/CmkDMIyNYHBFUEVMe6YyKjeJeDlcTkISZVgbTI/pqNUsFklKLjjSBgAOK7ww
	 F+Z2KwQWVong0wXXQ8+V0ZSGFvWiaDZ5h4sS4XJxLIbZ2fFZIxPTaoxOuGtDiqqk2p
	 5POm7Fu6D+GW5UvL7JwKYwMpdLwg7Fk9VuapkM9/kKP1TSnKEolwx2DF7Si7mSRIrd
	 sOsKsJcq3KHr3/WfnhQjoqUbxvkfzKhwu5tV0eQub0nvw/FciJHAai10aBfmejDR80
	 AtrxvFKdZX8LBzEx5XRqDkXsRxFcCYz4AbrgoAwnqroScmdHvFihxmVOAjnqug+A/B
	 0tyQAf6oAtP6g==
From: Lee Jones <lee@kernel.org>
To: broonie@kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org, 
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
 sbinding@opensource.cirrus.com, lee@kernel.org, james.schulman@cirrus.com, 
 david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz, 
 tiwai@suse.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 michael@walle.cc, linux-mtd@lists.infradead.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, michal.simek@amd.com, 
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, git@amd.com, 
 amitrkcian2002@gmail.com
In-Reply-To: <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v11 01/10] mfd: tps6594: Use set/get APIs to
 access spi->chip_select
Message-Id: <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
Date: Fri, 01 Dec 2023 09:57:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sat, 25 Nov 2023 14:51:28 +0530, Amit Kumar Mahapatra wrote:
> In preparation for adding multiple CS support for a device, set/get
> functions were introduces accessing spi->chip_select in
> 'commit 303feb3cc06a ("spi: Add APIs in spi core to set/get
> spi->chip_select and spi->cs_gpiod")'.
> Replace spi->chip_select with spi_get_chipselect() API.
> 
> 
> [...]

Applied, thanks!

[01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
        commit: dd636638446c87c95c5beddcd367d95ac6764c6c

--
Lee Jones [李琼斯]


