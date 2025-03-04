Return-Path: <linux-spi+bounces-7021-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68434A4DE10
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 13:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D11178D7A
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A22046B7;
	Tue,  4 Mar 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkL4x7tL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C62040B3;
	Tue,  4 Mar 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091651; cv=none; b=Tx/x1on3CVUvjtxkTLNSgOdRIWNJWD7VTBj7GqgiPza9lj1bbJEw0ywXJEY2lMmusdIHr8ZAMgIQ21zcbw6iLksVgusgwDn+1qjqcK8IpffqfGweIjwkzic/LZvdjnJ9/mJfOhb/r/w18RMO1Xxr+i2U2qnyvaUCQbkg/1sv3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091651; c=relaxed/simple;
	bh=7b5Aviksp18gj3Jq/M/ztXfxsWCEz69HfwGOfusOsCo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OofsAvOVLIOZdIyNPcvPi5Ek00OgJXkMklnKIn0Zgr2AhwkcrelWu8cWgwe/k44ENtUqeB/r+B6cFnD9VS1+hPc0wtH5NB7/tBB8h4HO7zVM6dp0QOkt9tCIBbMeOCDrZiR3T0dFqTzdQ5f0WyyqlHH9gMoGZ2tb1FQWU4aHXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkL4x7tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4FCC4CEE5;
	Tue,  4 Mar 2025 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741091650;
	bh=7b5Aviksp18gj3Jq/M/ztXfxsWCEz69HfwGOfusOsCo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rkL4x7tLqt7ImDjZfOPzjkOeP2FvDPrEC/cQJtAycV6AgYSj9SIblZCpQKL7EyxHV
	 XCFLRrSGQE8PQ9fOtV3z5M7ERYqhTOTxfvAn31fHV5pGYTx69lCwMMEJ0UsBr36pRW
	 ocvu3HQ++TOe97EWv46FpYD9sY/OTPTVtVMPLj+ChKoM3S//EcNse99Z5z48UUrUJP
	 w80gHguBe3dgtcjdRdd5VQJH8J9w1b7SRLwEV6cMAHmkIxbJVlmF73aQcXvl15CadY
	 dUOwxJQ8ox6Knc4+a/yaZ3ANo3xi//dCrB1iOtijWdHvCJTVk2X+gEmweouV/Hrv9d
	 34O28QthIyVMQ==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250224111414.2809669-1-quic_mdalam@quicinc.com>
References: <20250224111414.2809669-1-quic_mdalam@quicinc.com>
Subject: Re: [PATCH v15 0/2] Add QPIC SPI NAND driver
Message-Id: <174109164799.27220.16782141488752139254.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 12:34:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 24 Feb 2025 16:44:12 +0530, Md Sadre Alam wrote:
> v15:
>  * Skipping the following patches
> 	Merged:-
> 		mtd: rawnand: qcom: cleanup qcom_nandc driver
> 		mtd: rawnand: qcom: Add qcom prefix to common api
> 		mtd: nand: Add qpic_common API file
> 		mtd: rawnand: qcom: use FIELD_PREP and GENMASK
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: Introduce qcom,spi-qpic-snand
      commit: fd6bc2ba410bf7828dc2104bf78b51ccbb216c40
[2/2] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
      commit: 7304d1909080ef0c9da703500a97f46c98393fcd

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


