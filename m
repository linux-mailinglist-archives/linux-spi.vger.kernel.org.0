Return-Path: <linux-spi+bounces-11502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A38C83D81
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 09:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D173A898A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782862DF70F;
	Tue, 25 Nov 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd9qySxc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2429C325
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057465; cv=none; b=aoqNqj3F//zhrfy2/gHJjFFHvKWpzWHfsIx/3DwWJbpGbdpZjPtyLqjgKWUtWHYQzY1CjX0WrXGwyiT7VP5ogt7iElY5/AoITA2IamuAhttARcO6ZcQ0Qd9SRaYRZVEn5W+Vzugao/0x7Y9KIUHix1d9FSDp4dCU9u90zXA1uek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057465; c=relaxed/simple;
	bh=7spkNpWAHdCO6LwYsOjBoYTxKm0MC9Mee0VnjX/3HTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Hr9RouXgdA4SRkAcxaILeg1RA7QfJLjhKjThsavhM6bTKGAZrBvKxyei5nAmQA2ZcwKGaKWnbefjBjWHvDQJMAEST8IeyMjk3ZwK7U3BMm/QNJenpPS3lvclcrsB4Ur+Z5n7Adyl0Lpveq3ml8IZQlpW6FjKnyToekARFeSOlI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd9qySxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EE0C4CEF1;
	Tue, 25 Nov 2025 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764057464;
	bh=7spkNpWAHdCO6LwYsOjBoYTxKm0MC9Mee0VnjX/3HTc=;
	h=Subject:From:Date:To:From;
	b=Bd9qySxcPnooQSK2ExMRc+aLE06t47mZ71EIounsmZVZpHJsOsNny7a3oOrq1PPlJ
	 SopCigiP5fYN8ZfBGWoaoLtWv/IpgFKxux+jyxSa5sc2hWJ5QwISOJ2ZUJOY5BhhC5
	 8F8IAmAnFnciNdVpXQmeM9TpGYkbTc02j6rX3fG9wbiwhsnG48jJVZ3Uy+EZroMK0e
	 1zB2m1G+5PFlP/BMQ055v4LzTuyDAG0vw/qKA3cDOWS/h9RGwL3/1wKLoPcxucqzOs
	 t1qQRUBAxSWXPCtu7yN2Adi80dI6l+/D6fD53E+VFSUIeJi1Kn9X8/5271k995K+/J
	 3RaBEj5YlMiow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE423A8627D;
	Tue, 25 Nov 2025 07:57:08 +0000 (UTC)
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
 <176405742728.236648.7916246219816833037.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Nov 2025 07:57:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add support for NXP XSPI (2025-11-25T07:42:17)
  Superseding: [v5] Add support for NXP XSPI (2025-11-24T09:25:20):
    [v5,1/2] dt-bindings: spi: Document imx94 xspi
    [v5,2/2] spi: add driver for NXP XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


