Return-Path: <linux-spi+bounces-1244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A984F7F3
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4F1F22E85
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179E6995D;
	Fri,  9 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhUJUnro"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDF692FC
	for <linux-spi@vger.kernel.org>; Fri,  9 Feb 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490579; cv=none; b=kG01JzjjJ+cQQSlgpZeo6A6lwhny72o03GpD68JxpjzSzS51ASFVAY8NaSy9wM0fuvzUF9/Szyx16rNJfjkpX9pwvA8bdnMEUk5oBJ+SQzO6pTphiB7wAzZqUg2tLOu8PEbq8A+oZ9TEDpHdpXLrV/8UhLzanlHXCAdZs1BCHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490579; c=relaxed/simple;
	bh=F3L+0vJJ5/H2YEDbPTu7KjP37JPhcV33D7bemGXMjq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Q26UDfOPGlsD6o/JF559PwgH7ms6tTFuscOeQkGuJ/T1BU2zC7HJF38SXnwehUC/ta1PxvIm7OyIF+ENdXBq+mOi0C9c9+rjLCJH9vZnNr+/RgolYg2QzSj1Wj40TD0u7k26AqIBfIIRQkyUN4MGQMSxItz0GdGm4ApoQ7ed+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhUJUnro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A62CCC433C7;
	Fri,  9 Feb 2024 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707490578;
	bh=F3L+0vJJ5/H2YEDbPTu7KjP37JPhcV33D7bemGXMjq0=;
	h=Subject:From:Date:To:From;
	b=bhUJUnrovJXXY6GAyQ+PL3L4MexnBXP1h9LM3OY3lHfmjtR9q094kJux0NvH8rarQ
	 6NwwX36OnP1Jo4SXsevyaH3PsDxv94owA3BSm/WIywXaAbzG9C5NYSbbCewRA/Pc2V
	 MGLXmw/qaTl0gInGejjz3h0ZA+yxc9AObXaCXUGGLGtwVCrbFpSeSuFnCa1eWyU03M
	 +v+ilV0W9yxJYSWhGhVBgGvzvLFvgDAzbzrMJ1J6Cxs+SdoEwI6Du6MQWC0cQV91/C
	 mZh1cmM/2hReUTdguU1/6hgTaK/GM5Bgm479PezvFeLZQBocrhDzvp0EOd5R5YM8+O
	 6arDuNARGuqBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A70DE2F312;
	Fri,  9 Feb 2024 14:56:18 +0000 (UTC)
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
 <170749057855.26671.1651160267885353405.git-patchwork-housekeeping@kernel.org>
Date: Fri, 09 Feb 2024 14:56:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence-qspi: Fix runtime PM and system-wide suspend (2024-02-09T13:55:49)
  Superseding: [v2] spi: cadence-qspi: Fix runtime PM and system-wide suspend (2024-02-05T14:57:28):
    [v2,1/4] spi: cadence-qspi: put runtime in runtime PM hooks names
    [v2,2/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
    [v2,3/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
    [v2,4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


