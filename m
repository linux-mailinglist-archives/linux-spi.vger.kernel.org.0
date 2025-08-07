Return-Path: <linux-spi+bounces-9315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56999B1DD5C
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CA218C7BB4
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2855B2737FA;
	Thu,  7 Aug 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVIIHWHS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D626A1AC;
	Thu,  7 Aug 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593750; cv=none; b=exJ2dIERcKhWjukzf2UNnXpWXgQZopR98Rvd93tQaeXP95chjQ/8Bq8eYyNUskIXer6Zb00sMRYBkbzWG+lhZZ6f1YvIznhGtkNiGx+NUICbBm92t5lTrQLdId0IHrlftEeEcDhsiezm/kYGalm+RHCIN+JIhxqmkBCGrfjXXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593750; c=relaxed/simple;
	bh=h5F9tcewokv2v0wx3iMjy8IfFAlmrDNK0aJoLn0Qpyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KHcAk+uxner9j7XVPyAICFpsX1DaQEU1T62QL74iEqGEWunci/4mPqDVQc58ErjI8s4kyA2e1wfc3jMFNDZyRzujcsch8PtIuynwOQI7qU/bT5fuxEt7gtkLwiE1gqkvC4xB3KPnN7r+m9KiHF0E/OzBFC2HSkNZTLPHUCfXXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVIIHWHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE7BC4CEF7;
	Thu,  7 Aug 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754593749;
	bh=h5F9tcewokv2v0wx3iMjy8IfFAlmrDNK0aJoLn0Qpyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pVIIHWHSzdnCE18ikP5QEvNUXONkDu+GsxtTfXSJZf8la3IxFqoVXeLrgHgpo7ap2
	 u5mYkKG80fY4kWG6cDHeCxyMJBmUBv4RwY4iDqcyVnYkyT6XlCjrAsbw/ykiQkMnrt
	 5fP5V6cvNNbuhANfslRaan05LMbI/AdgnKNbKReJXbAhnHs1Eqc5a4QNlZ1ZgJt8RK
	 WvuJxbeKjb/0wXdkWcWeVl249jeOBk2M19GLLg9yKzIVSEOSNm/QvHJStB/Pnr7ox6
	 ZYnP1B1kBDd8z823yk2J1eLNkfLm5s9MRU+lxjjPiOYbGwXTjufvuJrs1YCqd2QS26
	 dWpr6mv8acvCQ==
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250805-qpic-snand-oob-ecc-fix-v2-1-e6f811c70d6f@gmail.com>
References: <20250805-qpic-snand-oob-ecc-fix-v2-1-e6f811c70d6f@gmail.com>
Subject: Re: [PATCH v2] spi: spi-qpic-snand: fix calculating of ECC OOB
 regions' properties
Message-Id: <175459374764.106952.4861259092289102637.b4-ty@kernel.org>
Date: Thu, 07 Aug 2025 20:09:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 05 Aug 2025 18:05:42 +0200, Gabor Juhos wrote:
> The OOB layout used by the driver has two distinct regions which contains
> hardware specific ECC data, yet the qcom_spi_ooblayout_ecc() function sets
> the same offset and length values for both regions which is clearly wrong.
> 
> Change the code to calculate the correct values for both regions.
> 
> For reference, the following table shows the computed offset and length
> values for various OOB size/ECC strength configurations:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties
      commit: 13d0fe84a214658254a7412b2b46ec1507dc51f0

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


