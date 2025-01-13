Return-Path: <linux-spi+bounces-6329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DBA0BDDA
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C02188906A
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C920AF8B;
	Mon, 13 Jan 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkS/VjQQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983220AF74;
	Mon, 13 Jan 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786710; cv=none; b=VZy+gfkwoHHN2kwMXjSZcHgzy7KiF8vkPFouqzjZWBgwgm5L63PkgXllWiMsLniGrC5uWvtM1Fn97K5yIGwr+RYF+GoJla7T5ACL1MZ0pi5F0ICV6LOGnKIMOT+Fz/vsw7NpIFrMLxtQMrg7mxg/WI4Zg0F2Z2qn9E+7bHL3/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786710; c=relaxed/simple;
	bh=iTbVU8Pz0CjjUYRkjDZ8bl0LjfmrHUZ8eq86SH++Opc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gRErjdk58SedDd999fbE6/HQ6QmHCm3F5UEde0kjkVnCxn3Z3Ikis7lZDW9EJLW9h1YmtcgrWMUA7Scv+ywyPkkHHL+I6q3CHOSH0OMYCMQLgEYU7zTy73eonwhhaf8O+nPpW49/BSPQvOFOTo7OmEnOwSb5kNU/eCrkKkNToPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkS/VjQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D04C4CEE1;
	Mon, 13 Jan 2025 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736786709;
	bh=iTbVU8Pz0CjjUYRkjDZ8bl0LjfmrHUZ8eq86SH++Opc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JkS/VjQQxwILWhm3/AXlmwAkKgsKVw01LeSqXydYZMhV23rCInpyXkq6Sgndt5mqf
	 itXDkQN1G6ijmp1O5+PlgRcgrPuWV31yZ+Hgyy7/HkgjB6LwrzncPN15QPkh1n7y35
	 UVdfjM6E19DQzcPosdgpA2EKJkBPGnnLkUEsnzRq3YWYs/Oqt+MXREav/646IzCrh9
	 fBrQt7S3QQ6+bQR4ha6cXeKgEZZUgGFrOlKoJ8qVbI08mfH9Cj2Kv0ICMcQjaXHT6q
	 W6xFyTT+x/2sbRuxwlLlG+KJ4JwKk+SMbrQ2YpySnlCpphkUO5t1cNFuimP3RSSqFh
	 9BlSwXqrmXEZQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250111185400.183760-1-krzysztof.kozlowski@linaro.org>
References: <20250111185400.183760-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: ti-qspi: Use syscon_regmap_lookup_by_phandle_args
Message-Id: <173678670754.71125.10656077676999925954.b4-ty@kernel.org>
Date: Mon, 13 Jan 2025 16:45:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 11 Jan 2025 19:54:00 +0100, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ti-qspi: Use syscon_regmap_lookup_by_phandle_args
      commit: 066855cfda50638616fcdcf4068948dc87c2f7a8

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


