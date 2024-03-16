Return-Path: <linux-spi+bounces-1852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687B87D7D8
	for <lists+linux-spi@lfdr.de>; Sat, 16 Mar 2024 02:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619B1B21CAF
	for <lists+linux-spi@lfdr.de>; Sat, 16 Mar 2024 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF651849;
	Sat, 16 Mar 2024 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3TazblG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBA817E9
	for <linux-spi@vger.kernel.org>; Sat, 16 Mar 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710554185; cv=none; b=amWAW+Z/kBYAiMLEcO+cusDhau5GvldGEILTDULNh7H/q2sAzAFoOD9t4kZp/af9UJQUxn/hXvXYSG8WntbcKB+OwpMHK6DGd3PYJinzoVVil/G0kib03itvOgOaUykNXfWtlYAX+jdHbaP03iGblEQ7YaJdXrNvWSPmrqDRHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710554185; c=relaxed/simple;
	bh=7xLPrn4+6vsKKNTWSb1tzhdqUjiykDq9vQzqlD3XehU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GAFa86Mbpa/pdGfc7j2on3uyvZDivjczNxqSFf+UZXUQIuaXMA92nxNFPpjlIHy43YZM4UndkzRAPQULuiz+IY35o27zxaq+s2w3KGsQzsth8rpaHTQtKIHxbW8qMT8qUMMB3Iaeb8MmGzFO3clcl8RkwhFPbjrOl3gB5ZrlQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3TazblG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D7BBC433F1;
	Sat, 16 Mar 2024 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710554184;
	bh=7xLPrn4+6vsKKNTWSb1tzhdqUjiykDq9vQzqlD3XehU=;
	h=Subject:From:Date:To:From;
	b=Q3TazblG2WhrLgjDdiqdg1kFJuM6cq0q0HHP13shmsh80JSRrMAzzjfQSAvhKeZCX
	 pw77jXY+oGlNLwNUObmndIc1eLH+28tpVxAIHJ4Dj1DQ+4Zel1vCnBeq50E7DhwcUX
	 gSt4z4PY8LSmhWl3qjLEeKzY6wRSOVMgLk6Jk8le5pcIfF6RYPmu07iXJdhsBl7JaS
	 HhGo5vSdEQCwsD2ev97gg412XAUcyVyV5JT6+RSbQovLIX6MdC65OjavhFQ4U9mZK4
	 zR8p7BpfJUUgAcVUP4vYhocNx9GLyizVu62QRulh+xFFnjRO7elFyXc2ozeMKFZmp0
	 bVaNs8EGgE3Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36534D95053;
	Sat, 16 Mar 2024 01:56:24 +0000 (UTC)
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
 <171055418416.14689.14174869247024839627.git-patchwork-housekeeping@kernel.org>
Date: Sat, 16 Mar 2024 01:56:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: mt7621: allow GPIO chip select lines (2024-03-16T01:03:01)
  Superseding: [v1] spi: mt7621: allow GPIO chip select lines (2024-03-15T01:57:07):
    spi: mt7621: allow GPIO chip select lines
  Superseding: [v1] spi: mt7621: allow GPIO chip select lines (2024-03-16T00:59:15):
    spi: mt7621: allow GPIO chip select lines


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


