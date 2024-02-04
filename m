Return-Path: <linux-spi+bounces-1005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90DC848C9C
	for <lists+linux-spi@lfdr.de>; Sun,  4 Feb 2024 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9309628328F
	for <lists+linux-spi@lfdr.de>; Sun,  4 Feb 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45214A84;
	Sun,  4 Feb 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7uPlQ2C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D01B7EF
	for <linux-spi@vger.kernel.org>; Sun,  4 Feb 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707040591; cv=none; b=QfNb4iHtHDNhAykC3cGyoXuPtUfhNxcTOkm5bXZkC6PCtvDDiKp9f063Kj6lRNGzxCaPJIV1gKdUFJ5MonD+KPJR3gxYJHGkMiajWDeZeTjhbaJo6oIfmgMNyh3zqdzlOxdA+EcAHQGtewQGFPLJKf1EWmGrraCHd/+exNrQb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707040591; c=relaxed/simple;
	bh=RltiCtaILhi3cf01vi9KhoGUFYw7FSW9JTNWEgWpm0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=se80lugFiXfDA2i/yuCNSfUIK5zVKNvLNzdnBb07C8nJY+PnlqrjuBt3KWqXLEyeTlgooGoufPhJOU6FKVmwvHOBUICZvuMffSfD9t4oc0NQggYYgB7GjG2FJndpptKp/1b/yzAjFLrj16gauloDZoN6FO9QaPPtGf5w5kJLSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7uPlQ2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63AD2C433C7;
	Sun,  4 Feb 2024 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707040590;
	bh=RltiCtaILhi3cf01vi9KhoGUFYw7FSW9JTNWEgWpm0A=;
	h=Subject:From:Date:To:From;
	b=A7uPlQ2CqAa8i43u9Kf4g6jLah0D3lcTm2pdZhTTKUx7ZTDl7R/1v1ytvljUWcxzy
	 VIr8Nxs+fIMPCDhB4IPfX5npRj+9ZXKPYplu9FGy3dlpAJOhUSRlLjqjQSYLfRNssA
	 02mcg3ihyyHuJLh+X8wvXorHJwsWJhzBgB3jfCci/wVC+JCOFgwGP9olqrY8o9F77L
	 m/ODRArq/Ik2XDmjNVzSeNQ8k7RIg1M4qHENzrvdsipYH+pz2k6GVq3LQTWs3sa94T
	 tdrG4PySP7mTysvXdwXwIHM327IIjWaK3oQzXzB05netQ7QsfXFZ2fbILqTgvXvBtl
	 enRnBHP3ghXag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F462C0C40E;
	Sun,  4 Feb 2024 09:56:30 +0000 (UTC)
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
 <170704059019.13518.2768237631954986355.git-patchwork-housekeeping@kernel.org>
Date: Sun, 04 Feb 2024 09:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: imx: fix the burst length at DMA mode and CPU mode (2024-02-04T09:19:12)
  Superseding: [v4] spi: imx: fix the burst length at DMA mode and CPU mode (2024-02-01T10:54:51):
    [v4] spi: imx: fix the burst length at DMA mode and CPU mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


