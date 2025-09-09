Return-Path: <linux-spi+bounces-9955-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12705B4AD10
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A67188BD1A
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D351326D7E;
	Tue,  9 Sep 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlT0LO0s"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4F324B02
	for <linux-spi@vger.kernel.org>; Tue,  9 Sep 2025 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419203; cv=none; b=iWmLNnbd6mMskSF7V+wNq0po+/Yw/rGVJZZr5UYixBWkw2GDDf4SeIYTpcAcauMBZB6fWpq82hOXtgeQ3Mt/f0C2s2SwpjXaFP1sK8r1v+1ATnfyCcgKCd7zcSh+Fa1Mttpg+XMENOwPJxseGTwCrG/QEUd2fay0Ec0kw/bkBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419203; c=relaxed/simple;
	bh=VN+UQS8KgKhkW3KGRFCkd7Uw2FpNXH0M0z7B+tHTQDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=coJ1CwDXVHsGCsAviev5Kas3qjIGedpES6IjiIyB2Yz/fhZVVNJMr/CdzCFMQuo+df/BiHLz+sWzv8I2bvjyUhwS4Ah6AtBj5RTJKKaFjt45cV/TvPJdeW/9lVB8QjJa4eCF+Mf5waPTTalkExNVC5q/n0nyNrgp/wCx0jOQtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlT0LO0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C906C4CEFA;
	Tue,  9 Sep 2025 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419202;
	bh=VN+UQS8KgKhkW3KGRFCkd7Uw2FpNXH0M0z7B+tHTQDc=;
	h=Subject:From:Date:To:From;
	b=NlT0LO0sWmxsRHnQmIyG3lhEbJjvqVIg4l05H0t5xBfCWBQ/vRILc87sCx+2VjtIY
	 YhvfJBCSmFhqyQvoNxUWBZFET1rNDY7g0bJFY2UuFUN1C24LA+dlvtH7GpEuUYZAwg
	 aiMFkG/62w70mBBmk/9GaZZwFD3kHRuEn7LRmsDEBxCOqUr8bzYLNpz2cdulvwbjxt
	 CcP4Zzgs6sgeG1KpRfBSRkwlEGef6UCjlI4R58g6/NHY6mizScRXKoFAGs7hxjUd+K
	 5uykkXZvJvUgsPIpVwkC68sGMxwW/IGj173IFHB+FLnyK1YML6x7/aTPx/vvVMi2W6
	 ZiOWX5MZvx1VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38E3C383BF69;
	Tue,  9 Sep 2025 12:00:06 +0000 (UTC)
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
 <175741920482.648666.10062565180706484046.git-patchwork-summary@kernel.org>
Date: Tue, 09 Sep 2025 12:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: s3c64xx: Drop S3C2443
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=997184
  Lore link: https://lore.kernel.org/r/20250830132605.311115-3-krzysztof.kozlowski@linaro.org
    Patches: [1/2] spi: s3c64xx: Drop S3C2443
             [2/2] spi: dt-bindings: samsung: Drop S3C2443


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



