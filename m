Return-Path: <linux-spi+bounces-7366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C033A7649A
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1963A843A
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BC1DE3A8;
	Mon, 31 Mar 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3G8Ov8K"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E41C84AA
	for <linux-spi@vger.kernel.org>; Mon, 31 Mar 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418572; cv=none; b=EdcG8QgmRltN5P4qN6soy4y9Q9vPzFbHdzACpp/W8G2Ep5yjeMUJ59xaFgHUmBCkR3HXj/JnV7KPklktxRopu9s5SgY6xiM4vjykB9RIBDfv5NsMqZkJyDBEe1BVZSrrc9rLmJMcUmOhFnzRIui7aKYX2mX6pMeheKMnjrxtwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418572; c=relaxed/simple;
	bh=wN+Uk961OjFcaZ9a3crmF5XN/Y4iO8AAzo+wtfAlsds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hh744q41xMCuu67r46Z0LIv/t/u2PGYFHT7uW2L2zrUJ/+2/zF8KqSdWopBjErRjQpb76WCAjbNjwQQNEYM8a9IAgif0f87qWnsaVW3dMuJ44Eqzupeiw6WBAjRTIQBoel3Y6vojirwGKrT5wBxRTyeLXERylz13nARttOFl1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3G8Ov8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE33C4CEE3;
	Mon, 31 Mar 2025 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743418571;
	bh=wN+Uk961OjFcaZ9a3crmF5XN/Y4iO8AAzo+wtfAlsds=;
	h=Subject:From:Date:To:From;
	b=j3G8Ov8K85T+l3+y/70KnHwc4oxtaTRoXoqa2OwFz4tJ4bnLkh7UtKCHt0/C/+B0t
	 UKELsQbEXu4ZfSCNLLnry737P9UV1wJ0aibnQlzR72sJ/0fkj/Q/C2lJb65UQZte4Z
	 3RaRb34UeqLZOuuc7TqW2vaWVvgZdW2l/cTr7rQlEcBPUhjv8hwG6NyOuIi+B8L5vL
	 llzcRRpQCyKOhw2RqSa/SeqR1nEanMNYjWt3lepFpLIzbOl0oWZXLQlPGWlQB8g7Yw
	 48rD67X0WMSefOZhg4xIggCY+xOAytMvFv/A6FLGVcUgV6KOjjFkK+M0+jo3hhyFQN
	 5ayJpvVYXOsrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE391380AA7A;
	Mon, 31 Mar 2025 10:56:49 +0000 (UTC)
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
 <174341860838.4105276.1814538800067263652.git-patchwork-housekeeping@kernel.org>
Date: Mon, 31 Mar 2025 10:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Group CS related fields in struct spi_device (2025-03-31T10:35:59)
  Superseding: [v1] spi: Group CS related fields in struct spi_device (2025-03-31T10:16:48):
    [v1,1/1] spi: Group CS related fields in struct spi_device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


