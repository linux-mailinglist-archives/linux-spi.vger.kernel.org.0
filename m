Return-Path: <linux-spi+bounces-11644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50492C902FF
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 22:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEA4934E0C3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDE2FE587;
	Thu, 27 Nov 2025 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxEgFFAM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AE29ACD7
	for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764278582; cv=none; b=VVz2TFJRJyum78PDCIqcZW4njV0deIvCE+PY4qvxjcT9iKlaREx2EqOJ1ePvSGegpsKMIhkPv/Gdz874IwlG+1GZFwa1uyyoCv74XzN442SagLHgbFUTW/SmrKJ0H7yC0cev051b5JJi2Oz0C6+rAiPfWz3f0wGDSCldeRQfiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764278582; c=relaxed/simple;
	bh=tXSf/faAQPYndVwHiJWHqc6R5big0YhsKzeQL44hlrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ODPaDt6uquWe8go0NSp5DidaSBiXZKUowjpfkr9oPoukbl3gRcaxJ83ghNQiNW2eLc4LHK8H1I5gzjbSVJWjc9fCi5sbdhensLNjhcHTVkM84ityrojcxJrPgDLnwiPfiqxAkhgUd3LGmABy7B8vK+fKQdmsJMFMaiJ60IWCxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxEgFFAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD712C4CEF8;
	Thu, 27 Nov 2025 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764278581;
	bh=tXSf/faAQPYndVwHiJWHqc6R5big0YhsKzeQL44hlrc=;
	h=Subject:From:Date:To:From;
	b=IxEgFFAMRGeADV329xnKFdce4Uq/UruKEDIFInkRocUEOVVAWGeXgTO8kFA/q1wF8
	 J+VSREKFGIhl3DdyfUvJNTFpbSgJtk3hsumf44CD1bOhvZhZ91L5iGRl7y1kWyrqjv
	 mjh/ZJpEtyByqvQyL99rS2Hl8br/FlM2TZ8yA03L5OQiU1kCedc1LyXiHVYO0De1ER
	 tiLF5n3Uq34P37yAUmWn6dAf0JlPZrwjPyuM329/njERxdnrNLari1/SZfCdAk+jC8
	 qVPw8SuunbwMdc5WwdKhUMzo/DwYvsENW7bYiLdhscjEOk7+rk3jYJ2mseJOSsI/6n
	 i0stuaNf7cpRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 408703808204;
	Thu, 27 Nov 2025 21:20:05 +0000 (UTC)
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
 <176427840385.40576.6491098156589505896.git-patchwork-summary@kernel.org>
Date: Thu, 27 Nov 2025 21:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: nxp-fspi: Propagate fwnode in ACPI case as well
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028028
  Lore link: https://lore.kernel.org/r/20251126202501.2319679-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



