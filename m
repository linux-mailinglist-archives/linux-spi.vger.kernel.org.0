Return-Path: <linux-spi+bounces-978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F5A845F00
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 18:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443681C23D0F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087B53374;
	Thu,  1 Feb 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE5Fxlly"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39D7C6FD
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810211; cv=none; b=X0W9uh7Rwo+bRY0Dp7PrL/RANsNMoYxncd8+vypKlBDG8yI5wdH441YBCzQewT5tBu7wpy7bzwJw5J/dVk/9aZkjIfudVIsSP+NcCLdiXelnibRXbFdIenT/nXWwYnUWoN6cOtdrBVqBMGQk47+jVdXc4aCquHbUWrZznycY/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810211; c=relaxed/simple;
	bh=QYZ6k/R4qQoVwy2RfZF3Q+JC5b5r3Ggm1iOW/ak6V3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KnO1RBGOkUYvVJ4I5eJ9pFlSsYjI0NM3fS6aP3oFEUg4+6DzXkBgb9p3yn9oMPKxgECNsWJTRYqNZ3A8zSm4dNMYhQu75rloR8V/XT5cFq46xq6fcsIRA6h66NMrXO/KEPr0FqAHDjCpFZ8TsCk2jkL1qZ2Ng8kowouaJtl4AqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE5Fxlly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11FBAC43394;
	Thu,  1 Feb 2024 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810211;
	bh=QYZ6k/R4qQoVwy2RfZF3Q+JC5b5r3Ggm1iOW/ak6V3g=;
	h=Subject:From:Date:To:From;
	b=eE5Fxllyj6HQGrlEL3lX6Itjgk1Gd5+pV2v0AAlHslzvahWi/BCE0Ik2mzBRshXEr
	 b7E5B75mgNhMt+gNsBVC/R31H+DbsLcoR4ivsSNzAWh4jBrIF2mGrgZfrGjRr3vSuS
	 q6s4ZWbySWtF1f66+3fmKZdmtkllgy5l/fVCY5Ty6/X2dKaPAo9suNzX6sBse9zgjr
	 Z+WRXfWFC9XA6+K1W30EgIb2Dp0DLHMMx7+pI7zJqsSh1PPiJhpfpFK4xrO2VVSb4W
	 rR+wSJpF1di6YU0cB7gQkHgSimkvA5ThczUlpk9MQY0HnZJQPJ0quUmhVNr9ONPKvf
	 oEHW7sJD/Em2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F27E0C0C40E;
	Thu,  1 Feb 2024 17:56:50 +0000 (UTC)
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
 <170681021098.13636.16261012053282047341.git-patchwork-housekeeping@kernel.org>
Date: Thu, 01 Feb 2024 17:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cs42l43: Clean up of firmware node (2024-02-01T17:26:49)
  Superseding: [v1] spi: cs42l43: Clean up of firmware node (2024-02-01T10:44:43):
    spi: cs42l43: Clean up of firmware node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


