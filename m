Return-Path: <linux-spi+bounces-12093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E8CD9A9A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA51B306CC1F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2773A2DAFA1;
	Tue, 23 Dec 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB1P2PCd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19D341AC0;
	Tue, 23 Dec 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500338; cv=none; b=UWZFiOV76WfZEzS0gD9md4h7YAzDdqheF0qmBfy2fJAS5PYzg3yDoWcr2BfP4I4LldI2gnENSIsvkWU4BVhTJF8tZgoURv2iR2+N+hpeHlUaVqMKyj6G74S4ituKN1w5BFrPb1Rbu69gv5QBhRTrI1iWG9XRfaGI0AFCEM3kGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500338; c=relaxed/simple;
	bh=OwbemNpR1ktGSuht/u2AlQjG5CgDtN0dkOfw1O2uQJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGJfclR4YMtFa5HkTR3k5+q3Tq0maxqeOWGHWmWjn30MyNNfk7+viOtM5DZEmPtFcmo8hixRtNCWN85ASV3C8upfW1CwrBV+xDvZjWxjqZjXpxJr5h3z1x2P8vKxMbiop7bemV3FuqQEaSVJk6DfyPqBuI4/9UcWFUmf0X+dtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB1P2PCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF9C113D0;
	Tue, 23 Dec 2025 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500337;
	bh=OwbemNpR1ktGSuht/u2AlQjG5CgDtN0dkOfw1O2uQJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hB1P2PCdiNl/1InyFqZkFNiDqo134kLblDG8fGYAnooR+TcwLSlOSUkgcha3GBFtf
	 ey+J7fd9djkqynMK+Lqsh+giujiMkZyyfRMMQjzkR8rEc7TuFXNuk0N2mfHl4TCE1p
	 nWhSxEK96zHLme3/GDlBdZpOFUufcSTZ82Q0/N53dOqVVMsgBHbDNu5WB1/dVqD8ZR
	 HgB8ZzaHFvB5u83GnwoHIXFx2/PycXJvzSq3ctXcCaUauwEcSrH6CpyX6Th/EBAa5/
	 /H0mIadat3NBr4KitScwM5QGr3XloGdHpf9TAUjoznZwH/Uf1V4xXMTr2XfZ5U4K5i
	 hBBdSXtjzLVEA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 05/13] spi: cadence-qspi: Remove an useless operation
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-5-8ad505173e44@bootlin.com>
	(Miquel Raynal's message of "Fri, 19 Dec 2025 20:22:07 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-5-8ad505173e44@bootlin.com>
Date: Tue, 23 Dec 2025 15:32:10 +0100
Message-ID: <86h5thb76d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025, Miquel Raynal (Schneider Electric) wrote:

> Right above writing the register value back based on 'div' value, there
> is the following check:
>
>     if (div > CQSPI_REG_CONFIG_BAUD_MASK)
>             div = CQSPI_REG_CONFIG_BAUD_MASK;
>
> which means div does not need to be AND'ed against the bitfield mask.
>
> Remove this redundant operation.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

