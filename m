Return-Path: <linux-spi+bounces-5835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A89D8986
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EEF168997
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE11B3958;
	Mon, 25 Nov 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOlx82X4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121621AF0B5;
	Mon, 25 Nov 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549222; cv=none; b=sv+Npylt9PNZjRdQENYoaGDCCsc0hQUhMUVPxSj0Q8W18DMGZfWIsRQnyelryOQdKP6aRxUJZ6jcReV+Mk63Q7e2wgj1D9V2c3HSGHG2G6TQfGPT3Q2d6EsHdsbCj2SqHgO08w4qIqxvOIM4YXVtYjTS0jnZceN84CLOj9ympQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549222; c=relaxed/simple;
	bh=IsIi8uedJB2d9ynke7rCIfulXuPxooj9TCcL71ClcMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sOLDU8HcxNJPoUXl4AVRzoe3llw+d51ovsGeorqvSDcmEjChW7+V2tk80LBdwQKznrk/WZT7HKAYEM1JsbuckRh+nj7W15TCWWqeChzzEGkES+R8fjhY5fUFWT1dHgp9l21fZlGeFJ6vYD9zTxrbAtQDmbU94X0y1rTcFREiiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOlx82X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF9CC4CECE;
	Mon, 25 Nov 2024 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732549219;
	bh=IsIi8uedJB2d9ynke7rCIfulXuPxooj9TCcL71ClcMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UOlx82X4RX72arozgLh4e2tPa5MBNgO9Qi33L80gyMCT5HjS3dpmJp3XcrgrLgn3z
	 sLdYwVrnPcuZZK6sYdsz07Uby1Ub0Yq1ymSivQwLuoP+hnYgxZ8ZvLHm2puHpEKFzo
	 Zd4eIt9Z9J4zPlr8vaS8GS+lEpuk3+AxWZSuZJYvVvWw69g8pNKdcnSlqXP0EoarjU
	 DFNpMRE4VMztfKHAdv8F+FMlCsVbwyZF6PpHE2WqVgpqLNqQNCi2NDx69cpoSp4+vl
	 y1l9ocGmPLRxnohePvYVpIx7zPpWzDskSICF3wCmjm0G7d6xyhzlczV4vCrkEMyVYv
	 XCoI3aMIq981w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: <tudor.ambarus@linaro.org>,  <michael@walle.cc>,  <broonie@kernel.org>,
  <pratyush@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <miquel.raynal@bootlin.com>,  <robh@kernel.org>,  <conor+dt@kernel.org>,
  <krzk+dt@kernel.org>,  <venkatesh.abbarapu@amd.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <nicolas.ferre@microchip.com>,
  <alexandre.belloni@bootlin.com>,  <claudiu.beznea@tuxon.dev>,
  <michal.simek@amd.com>,  <linux-arm-kernel@lists.infradead.org>,
  <alsa-devel@alsa-project.org>,  <patches@opensource.cirrus.com>,
  <git@amd.com>,  <amitrkcian2002@gmail.com>,  <beanhuo@micron.com>
Subject: Re: [RFC PATCH 0/2] Add support for stacked and parallel memories
In-Reply-To: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com> (Amit
	Kumar Mahapatra's message of "Sat, 26 Oct 2024 13:23:45 +0530")
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
Date: Mon, 25 Nov 2024 15:40:15 +0000
Message-ID: <mafs08qt75nkw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26 2024, Amit Kumar Mahapatra wrote:

Hi Amit,

I've been meaning to look into this proposal for some time now, but one
thing or another kept coming up and I never got around to it. Well, I'll
try to get some of my thoughts out with this reply. I still haven't
looked very deeply into the past discussions, so apologies if I bring up
something that was already discussed.

> Hello Everyone,
>
> Following an email discussion with Miquel regarding the binding changes
> and overall architecture for implementing support for stacked and parallel
> memories, I=E2=80=99m sharing this RFC to initiate a discussion on the pr=
oposed
> updates to current bindings and to finalize the implementation
> architecture.
>
> Before diving into the main topic, here is some background on stacked and
> parallel memories.
>
> The AMD QSPI controller supports two advanced connection modes(Stacked and
> Parallel) which allow the controller to treat two different flashes as one
> storage.
>
> Stacked:
> Flashes share the same SPI bus, but different CS line, controller driver
> asserts the CS of the flash to which it needs to communicate. Stacked mode
> is a software abstraction rather than a controller feature or capability.
> At any given time, the controller communicates with one of the two
> connected flash devices, as determined by the requested address and data
> length. If an operation starts on one flash and ends on the other, the
> core needs to split it into two separate operations and adjust the data
> length accordingly.
>
> Parallel(Multi-CS):
> Both the flashes have their separate SPI bus, CS of both the flashes will
> be asserted/de-asserted at the same time. In this mode data will be split
> across both the flashes by enabling the STRIPE setting in the controller.
> Parallel mode is a controller feature where if the STRIPE bit is set then
> the controller internally handles the data split during data write to the
> flashes and while reading data from the flash the controller internally
> merges data from both the flashes before writing to the controller FIFO.
> If STRIPE is not enabled, then same data will be sent to both the devices.
> In parallel mode both the flashes should be identical.
>
> For more information on the modes please feel free to go through the
> controller flash interface below [1].
>
> Mirochip QSPI controller[2] also supports "Dual Parallel 8-bit IO mode",
> but they call it "Twin Quad Mode".
>
> Initially in [3] [4] [5] Miquel had tried to extend MTD-CONCAT driver to
> support Stacked mode, but the bindings were not accepted. So, the
> MTD-CONCAT approach was dropped and the DT bindings that got accepted
> [6] [7] [8] that describes the two flash devices as being one. SPI core
> changes to support the above bindings were added [9]. While adding the
> support in SPI-NOR  Tudor provided additional feedback, leading to a
> discussion on updating the current stacked and parallel DT bindings.
>
> Proposed Solution:
> The solution has two parts:
>
> 1. Update MTD-CONCAT
>    Update MTD-CONCAT to create virtual concatinated mtd devices as defined
>    in the device tree.

From a very quick look, it seems mtdconcat should already do most of
what you want with "stacked mode". The tricky bits might be devicetree
design, but from the software perspective, I think mtdconcat makes
perfect sense. You leave all the complexity to the SPI NOR layer since
it already handles them, and just use the higher-level MTD layer to
virtually concatenate devices. Adding a new layer between MTD and SPI
NOR makes little sense because mtdconcat is already that layer. Another
benefit of this would be you can just as easily concatenate any kinds of
flashes you want; they don't have to be the same.

I think this is a much simpler problem to solve compared to parallel
mode. Once you figure out the devicetree stuff, and I think the
mtdconcat changes should be simple and not too controversial. So I think
you should split the parallel and stacked support into two independent
series. This way you make progress without having to wait for
discussions around parallel mode support to settle.

>
> 2. Add a New Layer
>    Add a new layer between the SPI-NOR and MTD layers to support stacked
>    and parallel configurations. This new layer will be part of spi-nor,
>    located in mtd/spi-nor/, can be included/excluded via Kconfig, will be
>    maintained by AMD and will:
>
>    - During probing, store information from all connected flashes in
>      stacked or parallel mode and present them as a single device to the
> 	 MTD layer.

As I mentioned above, I do not think you should do stacked flashes this
way.

>    - Register callbacks and manage MTD device registration within the new
>      layer instead of spi-nor/core.c.
>    - Make minimal changes in spi-nor/core.c, as stacked and parallel
>      handling will be managed by the new layer on top of SPI-NOR.
>    - Handle odd byte count requests from the MTD layer during flash
>      operations in parallel mode.

You'd also probably have to add support in SPI MEM to signal the
controller to use parallel mode. You don't want to use parallel mode all
the time since you'd need to do "normal" operations as well such as
reading/writing status registers, reading flash ID, SFDP, etc. That is
yet another "cost" parallel mode support has -- it adds another thing to
SPI MEM (I'm not saying the cost isn't necessarily worth it -- just
pointing it out).

From the SPI NOR side, this layer would have to make sure both flashes
get configured with the exact same settings. That would need SPI NOR to
export how it configured a flash, ideally in a stable, well-defined
format. It would also have to ask SPI NOR to construct the SPI MEM ops
for it, and then edit them to set the "parallel mode" bit. Perhaps the
dirmap op templates can come in handy here.

It's hard to say much more without seeing the code. It would be
interesting to see how you can manage to get this layer work without too
much intrusion in the core.

[...]

--=20
Regards,
Pratyush Yadav

