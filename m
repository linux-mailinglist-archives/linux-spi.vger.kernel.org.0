Return-Path: <linux-spi+bounces-12088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F66CD9993
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 586123055B8D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C332D0C7;
	Tue, 23 Dec 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfrCvXbT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9E31A064;
	Tue, 23 Dec 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499512; cv=none; b=Kq195H9XI1gY9kgDAfeL05KO0CVIbetHlPxyKSlQTUAu5f/hm/2RD3Pw3eVWWA44l7GDdgvW4kkPnnAWgg3NcgQse9flp8G9sAd1M9vDYj9jtIn2QP8Nc8qCW+DZO4ozNqlSFNFtwyxg4GPni51WVm6ul9Zdjjr8Wqj7D3aUhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499512; c=relaxed/simple;
	bh=9UJXzz8GFDuZuvCcVG3aBJ5r3cpPY0/9c/EAWcyfGB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VKHnLuKJH9xplfHnWI/ap5kR1+VWDs/IWyAawQwpkaODBSFIsKjRAXvG/Z7ZhMk+ITg2wUTeH85bOzFnvFD+fwrazpH/+q59+BPvk7HWOP/sxhoxHtADKFLUD+I2KMHNUvn9jyQPzI3cOywIzSbaycXoDIR2MR7VcJTmj/m/Kt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfrCvXbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B8BC113D0;
	Tue, 23 Dec 2025 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499511;
	bh=9UJXzz8GFDuZuvCcVG3aBJ5r3cpPY0/9c/EAWcyfGB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BfrCvXbT+2hhgzzNb4/BGTeSLMAnY8sm6cwSAs1d1d6lQ/zI97T92aUWeeb5ttPWh
	 OsbI6TW9TrbGHZwvsTu6Z3H+8sP87a40iQZC3KQtpyOyw8ulkFz+OWqZA3Rw2EQhJR
	 cWWopN2fzBry3ubSnyRqTBRD8jhkjZarjlXRN/puJDI0JQax8TAP5r5POm22YtqyDS
	 n6FZwEl+kafRDeIWiIOyNH0h6JVCfkldGf1tWEgPNo4P0Vy6WZYAfPPms/8snE8bnn
	 y3O7KbcfwyY1D6JDKoYcITGMdijEMVIP3ntQ3wwmF0AGFxG72JtzTtquPT/NCFXw3V
	 MQPb1fvnU4MWw==
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
Subject: Re: [PATCH 02/13] spi: cadence-qspi: Align definitions
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-2-8ad505173e44@bootlin.com>
	(Miquel Raynal's message of "Fri, 19 Dec 2025 20:22:04 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-2-8ad505173e44@bootlin.com>
Date: Tue, 23 Dec 2025 15:18:24 +0100
Message-ID: <86tsxhb7tb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025, Miquel Raynal (Schneider Electric) wrote:

> Fix alignment on the #defines.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

