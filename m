Return-Path: <linux-spi+bounces-8232-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6707AC08AE
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6410B7A6F9F
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86D267F5D;
	Thu, 22 May 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb0q4Zfs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9898170814
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906193; cv=none; b=Ib4RoJOy37KGZ0bz5myE1eszrHEphcoqZaJ97C4cQEDMfDQrnW/itwKPJpwhyruqV2+EKR9Rm/4pORhJLadD+a7CtklwkIqZFZ6IPtzHhFw0iwfe1AsICZC0S1trdB+QRU+48fzL0bYPA6/1iKw9s3u9+hHgIHXfmzJMvfGwGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906193; c=relaxed/simple;
	bh=t7nK1mRgNhbajUt4xA6fydOhzO+EnfdJ1Psb/tLTVAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NFF1vI2uOPgEY/vsX4BNuCIAZ8fIWdlDcX4K7FOavFYA1G9CGFkBLVSt6nh4XozSsZilo65FE/B2BYtRSLMaLnaDfKB7YT439RzjojrBit485GeELsAlhIn2HXXrtCvpHxhZT2USQOnaPkfvsYlEbXhoPyWdEaRljzqV3YLot5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb0q4Zfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4C5C4CEEF;
	Thu, 22 May 2025 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906193;
	bh=t7nK1mRgNhbajUt4xA6fydOhzO+EnfdJ1Psb/tLTVAo=;
	h=Subject:From:Date:To:From;
	b=hb0q4ZfsZYZVyZAav5qfw0TSPeXexisOm5dO3oEYQBPJW180L/a/BVhdqK69+Lf14
	 lvThlE1TuRsDmnx93A8IE3NI+dvaPk5c12hy+AzorS3JgedaOsUzTPn1AYGEyVmd01
	 XNd386i2E1S++LFgKlIkh9KOj/y9QysWoIfzT3kSxKKG7IKmOJYMt+0sDDHIk9BAlG
	 Lv8+ygbHCG3MHsXfuN2g6drl+WDqV4aKu5oLNRTHvRI/oK3+EhOuQQ0xLHA2VPpuOT
	 vem4c8/aozjVjg80Oa4oaxRvs2cEPTGyG6Twz3LMBJd5CBOFnfL+7NJcrw4AbfnwdJ
	 1UpqXX313xyYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1C8C380AA7C;
	Thu, 22 May 2025 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174790622812.2464246.17318383151688156233.git-patchwork-summary@kernel.org>
Date: Thu, 22 May 2025 09:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: reuse qcom_spi_check_raw_flash_errors()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=962775
  Lore link: https://lore.kernel.org/r/20250514-qpic-snand-error-check-v1-1-c0ebd3aae72a@gmail.com

Patch: [next] spi: spi-qpic-snand: remove superfluous parameters of qcom_spi_check_error()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=964704
  Lore link: https://lore.kernel.org/r/20250520-qpic-snand-superfluous-params-v1-1-86dd4963e90f@gmail.com

Patch: [v1] dt-bindings: spi: samsung: add exynosautov920-spi compatible
  Submitter: Faraz Ata <faraz.ata@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=964882
  Lore link: https://lore.kernel.org/r/20250521084324.2759530-1-faraz.ata@samsung.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



