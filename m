Return-Path: <linux-spi+bounces-1791-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEBE87B182
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 20:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4666D28BED2
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79A265BD6;
	Wed, 13 Mar 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPwmAjCr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E465BD2
	for <linux-spi@vger.kernel.org>; Wed, 13 Mar 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356191; cv=none; b=U2d7i5P5PWmrkYC5tGh3U21eYm5mYMqZbh8x92kemwe/g3qrAWmurnv1kEXzpimQ/TUNbF05qWNvwdOnKJRt+IJuM41zGkzzP0dDyeGwVQApCQOk2lR5WQw+rrgnXM1WLL4gPJ1KJnIdZCv3bkQEQq+pt6GOm9bCYIaXW5Km1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356191; c=relaxed/simple;
	bh=yU79TyCMIECL/Is0UoQEG3y5uohN9x8rElJT8xtQDIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uyFiDqvf0EExLFIufDjAnSe6JrLUnRDkUBzrcV/sstw66M78+BPMb2bQjU/PSv6tvqP/7M6OQt/69yc71FnsDe1zd3n/N+Stv40OcHN4v1F26ZFO/XVXjHoSC9ra872qjeUaRuY1JYI4WxqdHuLGIZ2QmzpHq6ym9nQJiZUF5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPwmAjCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC02BC433C7;
	Wed, 13 Mar 2024 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710356190;
	bh=yU79TyCMIECL/Is0UoQEG3y5uohN9x8rElJT8xtQDIA=;
	h=Subject:From:Date:To:From;
	b=HPwmAjCrtLTG7sX7pd0U4i9tHu1N7Q9MQMF61aFcwfvqz2Y8NoNht/6UDXHLG6kSO
	 4tFsYg9zooGVvnIg+uEl59j//bBujXZIlwtpnS2Cieu1PjobSur8f33VRIssVE0Fjl
	 6eKgwL26CW+Yf3Ks3IDxazyqMIktIC72577mVcPTRQa6fSHa1tMZ7iYnmoghFZ6FXM
	 5w2bKUGdUTjO2ufXtwVzdfl0rXVnar7PgGsEQezpbNAgoZ9nEDxSxMn+YKrvLnBK3S
	 mLKeg9Fg8ub9dMwoNn6jnndwgAvAHMp1w2Fo9EozSh3+YzArALCojLZHGQ604NzzF/
	 fqyHF9IOHCYQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE88FD95054;
	Wed, 13 Mar 2024 18:56:30 +0000 (UTC)
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
 <171035619070.16215.14838522750852673764.git-patchwork-housekeeping@kernel.org>
Date: Wed, 13 Mar 2024 18:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length (2024-03-13T18:00:03)
  Superseding: [v1] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length (2024-03-10T02:25:32):
    spi: spi-imx: fix off-by-one in mx51 CPU mode burst length


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


