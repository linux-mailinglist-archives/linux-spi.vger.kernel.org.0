Return-Path: <linux-spi+bounces-7194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A067AA6768C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5DF1892802
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D820E018;
	Tue, 18 Mar 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoameO3I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145120E009;
	Tue, 18 Mar 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308655; cv=none; b=SpjARyKMmNfN0fTogfGKkvTMInZ5FPChR7+x1E2VAJ+xhxXZs6eSD8vlwQhzBWsxRivWW+7H5Suz5a9OjPq2AKg1MaRSwmsWg3Ohi+xtCCGlTpYxiCI7cWzfsvT8hh83Isq88CEd2ppgY4ZeQi4kKXgjkMsEcELjsFWRYDFffys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308655; c=relaxed/simple;
	bh=HzOhTcdxdlkrgpVUf4datNhvlWOIYGavDnRmpCcZZLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UncTFngGZq9a4zbxRJlEjtgvzOYiHgy7B1OqGDjHDMF20DX830Q3/hC/qHljccSaeMxAN77LD+P92soSVQwADt50okBuXdnw06HmM6aJVLptHZkcikvyPkmz5oYQ7yQ66lWfCtAJD5Nb0LByPsJmldbsJpf/1lzYPYXmWk+HERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoameO3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4805CC4CEDD;
	Tue, 18 Mar 2025 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742308654;
	bh=HzOhTcdxdlkrgpVUf4datNhvlWOIYGavDnRmpCcZZLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hoameO3I5Gs567NG4vVhFrGttx8yUiSFvvmgKTOiASLYSHZmkz2u59akHLY9xktZJ
	 D8tihjzMlmVPcNQk02a/1sq0MWgPZ/MkEHwXlFg1R5T7XwAwgJplqqvL8zl8Ku+ZFy
	 Ta0EGoSHYI/VyXCPzUhyFPEGh90+Y3Hzk/ZYVyGG6zE3EllWKuyHUSh97Sa4V8758e
	 qlPFP1uTKj2i42Cj1d8v0fcvcsCiEmzFfU7UPgZ7YLCRKReGb2vL5oKYUsgterhtgI
	 SIlOPZV0eWi/vNUP2wnwGBfxGxPUphIIaiVmmhIRTyWKetAEJz6DzDuYlhIBYMTmom
	 hcykfS3BPPfOQ==
From: Mark Brown <broonie@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>, 
 linux-spi@vger.kernel.org, Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20250318080913.31455-1-lukas.bulwahn@redhat.com>
References: <20250318080913.31455-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust the file entry in GOCONTROLL
 MODULINE MODULE SLOT
Message-Id: <174230865302.108912.14106694802921893219.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 14:37:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 09:09:13 +0100, Lukas Bulwahn wrote:
> Commit 8f1cc5242544 ("MAINTAINERS: add maintainer for the GOcontroll
> Moduline module slot") adds a new MAINTAINERS section referring to the
> non-existent file:
>   Documentation/connector/gocontroll,moduline-module-slot.yaml
> 
> It intends to refer to the file with the same name in
> Documentation/devicetree/bindings/connector/. Adjust the file reference to
> the intended location.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: adjust the file entry in GOCONTROLL MODULINE MODULE SLOT
      commit: e7c7c1d2fccabf31d646fd1916cc0e2dc727e99e

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


