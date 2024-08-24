Return-Path: <linux-spi+bounces-4297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB695DC25
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 07:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE3281426
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A038FA1;
	Sat, 24 Aug 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVR/Yu2j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1FDF71
	for <linux-spi@vger.kernel.org>; Sat, 24 Aug 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724478997; cv=none; b=LOmRxmreJDOqPTKNTkq7tMOBp2BvwtQqk2KWc+eaOKbofi57TKHGgBNyeXM+4FYD5hDoDKfqT2gW/n/6fVcwQbdqVLkgjD4h9+DyZqksDtUDrBwhWFEWHv3lWqztjWKBa3nDSv4rruoLr3oiTcxbzLXB3+V7duqKq38dok+jxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724478997; c=relaxed/simple;
	bh=AGjG96grHyow6hUg8DySVusTJkirA1ttvr7wd4iLSEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AbEr+FCCzW0Yx9iEsTlHvQNerMfYPpDpT+wEYfMTH0DY64UdkVqcSClpckls6xgo/+nL15kaKuedzkeg9RPt0Q37Rp1pHP69kEw/0vQbhurHGlOtztLcm/R8VTHtP6sCn8CaofXtNfOM5bKwv1r3qbzL4nCE3HJPd12Bbl/WypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVR/Yu2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D675AC32781;
	Sat, 24 Aug 2024 05:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724478996;
	bh=AGjG96grHyow6hUg8DySVusTJkirA1ttvr7wd4iLSEc=;
	h=Subject:From:Date:To:From;
	b=BVR/Yu2jpvqEjeSuV83tpPoPH0Kjz3Qs7shDgdQHIKgRvnJ3gd36PGufMhxJWmLWq
	 /0zvIbRBqK4NXL6b6FPukWau209lvyVtr8tlj0+iq+hxvGQlRyTUGzTbw7HJZ8iHaX
	 AP+PdUa5fcrJWFk7OrSyvbEI7nOO/YWuQBKJO9Ad9qxLL4vDuQNpOHSuf1NSa2FY2v
	 oF4SSEk/8c1NoDvsjz9O1UlyL4gF3cT0Ie+ooXMoL7MqsBL1NPLkS4FJsIodYNtP9y
	 /Cs8j5TnjjhFGerIctJLnzZsvUmYJhZEwxbZe2UbuV5ffk+PxtLzolgPa2K5Yz8sXW
	 r6VVmSF7MRjRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B392E39EF648;
	Sat, 24 Aug 2024 05:56:37 +0000 (UTC)
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
 <172447899615.3173246.11812671976692342817.git-patchwork-housekeeping@kernel.org>
Date: Sat, 24 Aug 2024 05:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: rockchip: Avoid redundant clock disable in pm operation (2024-08-24T05:14:52)
  Superseding: [v1] spi: rockchip: Avoid redundant clock disable in pm operation (2024-08-24T05:07:15):
    spi: rockchip: Avoid redundant clock disable in pm operation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


