Return-Path: <linux-spi+bounces-10316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F7BA5454
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 23:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DBB741DC4
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D01FF7C8;
	Fri, 26 Sep 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsog/YCp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592A1C28E
	for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923815; cv=none; b=shOnEehXW2XFsRWFbJKShOohPQ9j3oge2/5cDiy/9VdM3DkjBeD5Z4jS3zya6AFLzmv0xs5Mhn/iH7Dty7dmK/x0AFQ0EjkR/e7l9fvtL1nYelekZ7ejaxSsWdZpgkdlcnXtPpGQtY9pnURHaaEI63fuowK1sTqzDuzK1zzMNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923815; c=relaxed/simple;
	bh=Xi5ypbJ2RHBn+9CxucKjYfZpQeeRcYMlKbtAWE+RQH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=m0smj+YU/h7i5IvjiQtfcBua73PlOZ+VVdea6Bc3XPchPIGzVOR1Y4v2yme92zcq73OwIzSHXYbnWEDA+kEZlDSdKOnxmuqXn7VBUxYDkyYYxQO4caTxn8rpPDdyYhSTSLaWi83W9KNSO/vLivVD+aPxvTp2bsBvWCkTREt8cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsog/YCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D0C4CEF4;
	Fri, 26 Sep 2025 21:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923815;
	bh=Xi5ypbJ2RHBn+9CxucKjYfZpQeeRcYMlKbtAWE+RQH4=;
	h=Subject:From:Date:To:From;
	b=dsog/YCpr/SIgXBxklh+ZONZeKoD2AJUqYD4Fy1UgGoB0x/NcScWyuSGQgvqxbMGz
	 YESRlITc7c+qUlF1Bxkgn6HQ0mHjGCsnM9jr7LTouWJh0zsTW4NqCImBrrYzKgNHLP
	 tbzriNEZ6Z1+eavravv3iGeRfIv3RexDVtHzdhYAlyLTi+GmUNEk3he/1zXALJbzcy
	 PQPlT7ZH8GiPs59NUVug+z0u6UDoLOnVXxUpOu143VDOiVjdtviefMUC36n+DdJIB6
	 yA49vKKrMkGMp3NJ8a9l0CzhrCSgGce2vHa0J8EAB0NsbYWLhfF+NN1eBlaSFfk2z9
	 wsLa0OYcTr3lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74AB539D0C3F;
	Fri, 26 Sep 2025 21:56:51 +0000 (UTC)
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
 <175892380991.72726.13238345092181724995.git-patchwork-housekeeping@kernel.org>
Date: Fri, 26 Sep 2025 21:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add SPI offload trigger offset (2025-09-26T19:01:05)
  Superseding: [v2] Add SPI offload trigger offset (2025-09-18T17:33:49):
    [v2,1/2] spi: offload: types: add offset parameter
    [v2,2/2] spi: spi-offload-trigger-pwm: Use duty offset


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


