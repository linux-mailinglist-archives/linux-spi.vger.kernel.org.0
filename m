Return-Path: <linux-spi+bounces-8229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E24AC08A0
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70201A26112
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14A24E4C6;
	Thu, 22 May 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJsEhVNj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D870814;
	Thu, 22 May 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906057; cv=none; b=svmC/8OxwQffUfT/zkONCM5VGa8iiWy4+Jy1VE0hRohTFC1vE5JNFGolgc33F3iv+ZqGHklrvWs1cZC679dTMwgQIjY1Aa/Mn20JLElx5f4cuEGg8ryJruIforL4tHfXQqmryjE+JKkgX729upP/TkhY0dylZsyPkSPdtAqfJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906057; c=relaxed/simple;
	bh=sAftpgTXoshRrtSj+br63QRHVO9ufA/GYUeV/EcMd8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dsPc63QNo0Ozq34eozh9kP3HLO50MGJxaOdMGB7b3UUPiy1TNZO1odEHJMnOHp16gaHrSHKcLU5W/A4aaWjQ6aejz/4l7KhntcWu4m1uSx2s+ThmFPis67lQJdiRUhZruAJSQvNnUSkvKJJ4a46pKSlUZbe94zCAxQnR0inidDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJsEhVNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0871C4CEE4;
	Thu, 22 May 2025 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906056;
	bh=sAftpgTXoshRrtSj+br63QRHVO9ufA/GYUeV/EcMd8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hJsEhVNjsNef0ES3kvNB09lKggIkq3qKblVH+eA7i88ZxKscu1xg9YIexPxRq643g
	 NJ/DH8p/x73VDufrJ1yoiCZ8NyQ3WMgeaKmQDHaQ7W8NIOYDOKZ790/7SjBHpDv7zS
	 navPrxzWpMj6zd7uAvzy/IfJhSVbdpl0rtqcQ1HNn5ehUP266NGxsDhCOtqQ5zZOvD
	 Jb+9WOpUy5qxeawG5dIHRpvrO4U5irInczIHUe+bCKCAOE3dxl4233HlSYwZ+hyaUu
	 KVEP0L+3JPgg2s/JIOuoDpax45WuOoJi5tAjOLDXNvLGgmWhHopwX/gnbsN124ae+R
	 mkmnz72FWHOtQ==
From: Mark Brown <broonie@kernel.org>
To: andi.shyti@kernel.org, tudor.ambarus@linaro.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, Faraz Ata <faraz.ata@samsung.com>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alim.akhtar@samsung.com, rosa.pila@samsung.com, dev.tailor@samsung.com
In-Reply-To: <20250521084324.2759530-1-faraz.ata@samsung.com>
References: <CGME20250521083341epcas5p243dac11e4c5f2221473b8df8c3d7f060@epcas5p2.samsung.com>
 <20250521084324.2759530-1-faraz.ata@samsung.com>
Subject: Re: [PATCH v1] dt-bindings: spi: samsung: add exynosautov920-spi
 compatible
Message-Id: <174790605339.30110.2721459135664956247.b4-ty@kernel.org>
Date: Thu, 22 May 2025 10:27:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 21 May 2025 14:13:24 +0530, Faraz Ata wrote:
> Add "samsung,exynosautov920-spi" dedicated compatible for
> SPI found in ExynosAutov920 SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: samsung: add exynosautov920-spi compatible
      commit: 477d16c0919e82a7f5f673a6e3ae39a17c773037

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


