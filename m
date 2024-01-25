Return-Path: <linux-spi+bounces-750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BE283C048
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 12:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B371F2255B
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23131BF50;
	Thu, 25 Jan 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko0+ifiO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1139AF5
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180193; cv=none; b=tQpMfkF064Yk0QFrOCJEJmc0uRGsHYh0Tg3t3oUcqSOdR5rD3yu59eGmyBVqEiswMN/3NPG9CCpxVBZHLz3ygWonswUpzNFe+xr1Qwnp5vRBqzag2Iudv854aDWhg4o+TTDl95MaxP1ncuyOL8Dsp9W3XymcW2QbDjHvDBK/ank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180193; c=relaxed/simple;
	bh=+S0iDUzaWbgiv+9T1RJtsMlgjOkOZlC4jMMuPLC/bZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bJlrtyg0LwGQk6nDJmc0XfFj5/WK7NjzFVSluqUWQkha0fsTbuJ7Buad4wIGZlXgilbUJqcs5xTieZLtvlECb23u05OnjIYahJi2SIPJaKf/SdAAGP4+++NYR3eaBn1gQMdIf71VgWCZ/UGwzagcUdrSJhNmEXBH8/vwOL0cKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko0+ifiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B12C433F1;
	Thu, 25 Jan 2024 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706180193;
	bh=+S0iDUzaWbgiv+9T1RJtsMlgjOkOZlC4jMMuPLC/bZM=;
	h=Subject:From:Date:To:From;
	b=Ko0+ifiO0MGzKpv2nxzr5GS50Cwq70Gp4RGipom+gS/dgoNttvzvlNgEY2CTb+hCD
	 wKiO/nlD25PJFKtNTrzVwjaC9B1Rvppj2DFVFbkeV2zeUqEWtJ+5+Vp3FDY4lKCFOv
	 pHanTHuh/rAFuCc2JoISgeUXUwjzoDWlkG2m7U3s0EhlmmXGYyv8YTfo25uWcwLqej
	 npW3ujL/1qp12e2ikduyHgtfrG9Q8hULdbQsnHm8NpavK5qZslr7vn1N7N3B4TD8zZ
	 H8a6NMmjl7RYvAl1M9tbfJmN7y3xWvHi8FNTkDCbWmPxjprWGOWS01Xamm7ChgXkoJ
	 uPlD3LdBlzGAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B06CDFF766;
	Thu, 25 Jan 2024 10:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170618019356.5006.6465976172522287370.git-patchwork-housekeeping@kernel.org>
Date: Thu, 25 Jan 2024 10:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cs42l43: Tidy up header includes (2024-01-25T10:25:50)
  Superseding: [v2] spi: cs42l43: Tidy up header includes (2024-01-24T15:30:11):
    [v2,1/6] spi: cs42l43: Tidy up header includes
    [v2,2/6] mfd: cs42l43: Tidy up header includes
    [v2,3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
    [v2,4/6] mfd: cs42l43: Add time postfixes on defines
    [v2,5/6] mfd: cs42l43: Add some missing dev_err_probes
    [v2,6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


