Return-Path: <linux-spi+bounces-7850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A56AA70C0
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 13:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CE53A862C
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD5241671;
	Fri,  2 May 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mScyZaNQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D251BEF77;
	Fri,  2 May 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185997; cv=none; b=AMWm2QiyVHA4TrtycLx2orIOhxb+S9rug/0c/ovf28Jxf8aBNEJFQifxtMo0Xhjs5k/70kLIJUD3TUfRDIyn20yP9YZekF2JoLbWQdP+i9HBYyKhxwGQ0YV0gALHWkTTGS8zkZan/3yUz0VB3qFoOJ4uvaD6qgAzRDco0pO4oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185997; c=relaxed/simple;
	bh=gkrh52IbmYbFCbQFLYixSyK3E2Vd7dNScAr7oJkTbvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SkDsYOImkKJcPFi0aisrpU49I3p0Rug0Y0ROVvoXNU6XNDKQtmLklRaRJ/0R4VUEUfSRrLB27HWtAv7jnkkif+Hav5vPWw7lkABanmDCKE0MdohqbyZEeHjeOu0GE60Q7YHzXtIAEAg2WRBq9TNapGbuIRbopIjbJP6XPZhIt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mScyZaNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8400C4CEE4;
	Fri,  2 May 2025 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746185997;
	bh=gkrh52IbmYbFCbQFLYixSyK3E2Vd7dNScAr7oJkTbvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mScyZaNQwEWk+HGA5dYW32BLpcQKuHBAHw8BQW22FUzez9Hj/PUcGPagsj6VtSyNB
	 S0zv0hujMfmnsTVpJq4y/NePfbFWZgnn7qylc9Aghp18g4yQTXuzlOB/iJBa8hQ1IO
	 BVPpF9as/7+CdHekai++oxkWmN7sZnmE0OiNl8LJGM3KxRxYnJ+6XlYKOvHw+zd42v
	 mXxFrRDcWwPc6PBs+nggmG8hUNc2celrESSyKClo8hq2fuw1VaAebG7DGMuy+sA/Bk
	 keT4EPAIgES5bOoMYjn4GeymhTfW9JYzhwI2xu2m66dyrBI3NkrludB7+kylCTgH91
	 pzCdryIyxVAlA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, sadre Alam <quic_mdalam@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
References: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
Subject: Re: (subset) [PATCH 0/2] Add QPIC SPI NAND support for IPQ5018
Message-Id: <174618599396.4075974.7322251763578575960.b4-ty@kernel.org>
Date: Fri, 02 May 2025 20:39:53 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 01 May 2025 13:20:50 +0400, George Moussalem wrote:
> Add support for the QPIC SPI NAND controller found in IPQ5018 which is
> the same as the one found in IPQ5018.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: spi-qpic-snand: Add IPQ5018 compatible
      commit: 2dbe74c63cb73829be0aab0d0e7e68b87071b5fa

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


