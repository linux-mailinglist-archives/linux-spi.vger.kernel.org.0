Return-Path: <linux-spi+bounces-7062-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5EA5506A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AF21718D1
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA86212FB2;
	Thu,  6 Mar 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdnXGZzM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF51991CF
	for <linux-spi@vger.kernel.org>; Thu,  6 Mar 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277999; cv=none; b=hfxgiO4PfxhWVqODgnQLoo1WCFOYEB4wTbx347yPJPwdDJnN5kCWGVEZyaqizszP11Gb8tDozL3NTVzTiMXRbnHo3SV11T24sN+ztviEOpR8+gfAnP4e8Gz515s37twNiPYgBf7eilsjRknJjclo1rLgJJ/iSrzaLCcOFeFv0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277999; c=relaxed/simple;
	bh=O5cUfQBtI4RZJ8Kkldqg8cJWD31IYffmZPV9mpuGSnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FspsLMHT5aWdkz5BNySe2LzUqUKuAGl0WfP5E0CaQqHQWdr2dQxP98IMTZWvjn93OUDJJXuTb+lcWQi68qaXDnP+4ociEO0eXXFXN9HuAWasMf7l7f/BtX6DwTlGuFD8/vyulkzudkdk5a+BCxwkGbX+lb7SFJwXxz9NbR4k9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdnXGZzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0B2C4CEE0;
	Thu,  6 Mar 2025 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741277998;
	bh=O5cUfQBtI4RZJ8Kkldqg8cJWD31IYffmZPV9mpuGSnA=;
	h=Subject:From:Date:To:From;
	b=MdnXGZzMdGy1YTSx/Np9x0DEk1J8UerEciINYxhqRMVqe4ms1RMG4yszrDdNU3A/x
	 hFpWr/OBLhr9odMtUbmKe1/V66l+X9KCdff6vSiGf7nG6CQLgx9S5AmLc45eSZ0CsC
	 7Mimwnu/ENooyt63IUKSsTb1kYj3XfSWD9boPhGQTm0jO+raYAd1GLpjAp6C5oUjZT
	 cd4jdSqV7eL9PZW5lvCSk1NMPFtagNl8kTNy9+qpjei4ytacRKdAVCiCi1hC2plGFJ
	 MuhNV9T7oAaLQ1L7om6IWgtHi4gB04jxQPRd+1eU2/mePCYvTJ0QnK4504BnePBCJN
	 LhxC1yq0rtdBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B46C380CEE6;
	Thu,  6 Mar 2025 16:20:33 +0000 (UTC)
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
 <174127803167.1652351.8136855626771224182.git-patchwork-summary@kernel.org>
Date: Thu, 06 Mar 2025 16:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in stm32_ospi_get_resources()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=940935
  Lore link: https://lore.kernel.org/r/bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



