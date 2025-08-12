Return-Path: <linux-spi+bounces-9377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38190B22AAD
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB903AB49F
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2B2C159B;
	Tue, 12 Aug 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJzPEmUr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEE1F237A;
	Tue, 12 Aug 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008845; cv=none; b=Ve65QgobmyJYVLRC5cYSG8NUbl2vYwkvES/hvzINvky9HtrkSN9JEnfEntIDDRQ9p2Gx3DAtA00B3sh2OTodHux3YEfBFSkZR8EGJRyZIqhRvuJwJ8xFFlecedvqurNRaiNZZBgxsw/MUL2af5UaiqD4iUIjdBQZlWThmh4U2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008845; c=relaxed/simple;
	bh=gGOsuk0HqUZbPceh/FWXdNxVmPI/yvGvzEJu131frTQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IU8m67ESdeMNN2BF/7W0YjzJ7q8DnDAgchCj1f9d6h0z0DJyPLUKAD1XuYTpNur2UHc7+kYdfRuk0dPJMkAdTKWJuC3HSCjGcmYq5o3zDeDZ9vlIIAo4kL+b50prynNEc0RCKbyNhnpStuRB0piOGuegdCbT6qmbFAJu+e8kz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJzPEmUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC82C4CEF0;
	Tue, 12 Aug 2025 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755008845;
	bh=gGOsuk0HqUZbPceh/FWXdNxVmPI/yvGvzEJu131frTQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eJzPEmUrzBGHVSCIlbMboucTSpN5nLL7GEONgzk+6njRLg+nzdgohDQvV1TzOwGHr
	 FfoKn59lZKsUS3prmSbuKxMsQvnRu3JYthTrsK7nF/TbiY0O5kz4DgX9f0OANXDAiu
	 00Rs9GOBaaRS/Crf0goWbzYhCyOJ8BBAmOWLUuLFjjftYRdP8HlvMoJ0SC8HkeND0g
	 ChYgZ913s/z+UBOwnFA2e4XLaugXSI2r7mkNQnQ83/2So/2phJ3Oi3+NYNzANAoFQ1
	 z6UT8/YPSUjvPAxWETe0QhNQVfFDD3AyZULyFSoum6X8VaYrcVi7s1IwxiugSDKlkK
	 c7+hn9rFh9Mww==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
References: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
Subject: Re: [PATCH 0/2] spi: spi-qpic-snand: cleanup 'qpic_ecc' structure
Message-Id: <175500884282.87496.16520963986341546507.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 15:27:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sun, 10 Aug 2025 16:38:49 +0200, Gabor Juhos wrote:
> The series consist of two small patches to clean up the qpic_ecc structure
> in the spi-qpic-snand driver. The first one removes an unused member from
> the structure, whereas the second reduces code duplication and removes
> another two members from the same.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-qpic-snand: remove unused 'dev' member of struct 'qpic_ecc'
      commit: fbec18dc9940a89e094bae890b8dc0af00ddc4ff
[2/2] spi: spi-qpic-snand: remove 'clr*status' members of struct 'qpic_ecc'
      commit: 6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1

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


