Return-Path: <linux-spi+bounces-7149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D7A61560
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710961B64594
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C906202F72;
	Fri, 14 Mar 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dofsPJ08"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E5202F68;
	Fri, 14 Mar 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967589; cv=none; b=jHs9560wrtRAcFucWzluEFTIZ7NyTW1AQ3Lw6HaH/Pci1oZco3gYL1zW0w7hQ+mW8Eaiegz85E4y2vWrMW792vmjcZK+v6KMmb5AvJMEX+W16Z36LGvLO+b9w6g/eQQJzXGIRDB7qiUjsCgqmN81pl9xGktEOV5oI217/5nKYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967589; c=relaxed/simple;
	bh=WcvIaJXZSoQm0ADUQKO1KQ8SqfP3MvACY1Lsy7BpMHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=afm/fY/nZWm29MbSw0pOjjngB78/mHstyuDYvhTC7oWM7SLLblvpPkPH00xsfztzaksBPS74xzQhsdyWUaLE4mS8FrOYHEx9fNZBiGd4Mm/Scjl0KSlgRX/0dYrGU90KAOp1/t0HokKMAIb9O3k8FBkmRQrPjmfwBcEyIZFhhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dofsPJ08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AC1C4CEEF;
	Fri, 14 Mar 2025 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967588;
	bh=WcvIaJXZSoQm0ADUQKO1KQ8SqfP3MvACY1Lsy7BpMHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dofsPJ08AKOVendj+CorudDO9G7YbrV1zXO3rRb7uUd9rBH6/RWSfbaTVChz7dODZ
	 z+HdzXzspsWrJRZAhDHsCpxjywdztIG6ENN9DamoP1gyX/AWShTwzIxsjpHGF/FPIA
	 uhBjkQmMlIFUCtRtokf5SQHRWvOrGA35NqXMzdzpalPwzJaMnPK66MsuQpchWRtwF3
	 9Mb/fzveJKlz9AqGzRmLxaErnrEj/wG42q6/VsqeWJjyZc2kECnlOaa7WMMg2PbUQB
	 KXM4DmfInYTcvsAu+IBXPX38hH/m47xafcz29v/xNwotkGdbOU40k1lu4eAuYj3icL
	 iaeJEkNRYWeOw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, 
 Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241109105029.52748-1-linux@fw-web.de>
References: <20241109105029.52748-1-linux@fw-web.de>
Subject: Re: [PATCH] dt-bindings: spi: add compatibles for mt7988
Message-Id: <174196758592.19958.17138223278523726564.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 15:53:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 09 Nov 2024 11:50:28 +0100, Frank Wunderlich wrote:
> MT7988 has 2 different spi controllers. Add their compatibles.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: add compatibles for mt7988
      commit: 3b2e1b87ad0870ad37ee8f2ca0ea6ede19a29795

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


