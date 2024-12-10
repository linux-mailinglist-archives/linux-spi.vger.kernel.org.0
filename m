Return-Path: <linux-spi+bounces-5987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E99EB157
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA22833B6
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D901A08A8;
	Tue, 10 Dec 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juAVK82I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D878F44
	for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835381; cv=none; b=q51EclQaiCHcy5N2yM8x53U/vYCswAxwFO+UqeAKauEzg+pxzGZdrHV/S+9uETfLeNaJtxccOj7gbiE9iNmmfJOwCMLHMkkTuurm+X1dmOpb4nEEuyXi461Ld1nTaDRLGemGJp+uVj3eSOaJPxZiFzswNawWbOKMqQnoWanNSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835381; c=relaxed/simple;
	bh=PauPORwwDeAVJIIXFC4uMsJXbQLL1bFfyhsV5NbT9i8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kWGOPayd67U4BbZNyvwWBpv2cAxPVehKOV+PReiMbKJF1lpXLQjQcqx3zjBYbiILg51d6FyQ7SY24XfgRoolU65iccn/qfwDPF65TLgXQ0uAUUr9mOPEuI66nsWD9PqDuCvLdD8Jn75C7+aCqgHSzo15hjnKsJ7lm5wchf137W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juAVK82I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08597C4CED6;
	Tue, 10 Dec 2024 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835381;
	bh=PauPORwwDeAVJIIXFC4uMsJXbQLL1bFfyhsV5NbT9i8=;
	h=Subject:From:Date:To:From;
	b=juAVK82I4G6rdUflzfJrB+4hpjM6tjiov6epk5wIqWKu8n3PNnvMlB4KbUNCTc98a
	 R4pZy+ngAqOQJE6Kpp/yG/IOfQqSPxYpczfiASGvISbeLmB85ZMobMC4xdY2LEa4EL
	 li5ba8RfGM+8gDdQlUI5iobQPxPVEKKdfdj+7gJUT7Bq9XDaGXVswAW8bDiu7AVX0w
	 m9Z7AQtvmBRHzCIlwX6mc39HkXSIuWLvZjSutNSImT9vZeWwcl5dXyB3nagkx6OoUZ
	 4I+A9WtqPjQFazUTbE3hUW0x3jXOGGiZHlxGzhab1EoNPtdDjVe5P+YTue8/OuCZ+r
	 SgAPrNErSGOzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB863380A95E;
	Tue, 10 Dec 2024 12:56:37 +0000 (UTC)
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
 <173383539658.799172.10798854214059470645.git-patchwork-housekeeping@kernel.org>
Date: Tue, 10 Dec 2024 12:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: mxs: support effective_speed_hz (2024-12-10T12:11:05)
  Superseding: [v1] spi: mxs: support effective_speed_hz (2024-12-09T11:13:16):
    spi: mxs: support effective_speed_hz


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


