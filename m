Return-Path: <linux-spi+bounces-5694-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD869C6FD5
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 13:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5368C1F21E52
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F27179954;
	Wed, 13 Nov 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiiqwuH5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07514C81
	for <linux-spi@vger.kernel.org>; Wed, 13 Nov 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502600; cv=none; b=TCbtlTX3Ocia2V9R1WiovX3UDA/S79JqXYqNfqEa4qeWhQDpNYQyxRHAsGIPl474nWRa/Uk8Wn6ZrA2lWficbNWNBxDAZ187O6lIgp4wgSpcHHRw6n6Vw0QkyIzbKb0khj0h6cGupMAA6SQ15fdmiMFw27kBgjOSDR9TP38XHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502600; c=relaxed/simple;
	bh=JdloBukq50lNxkkXMIVzIjVCPbnmjAVlp6mKkRM9BcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mnVknRSU4EsuoB0u6ziuWjCd+liatr0KNcAZ127CHP8pF65AzS+kHRbYXshpSefCUlufXpkVTWgaKJSgPg9mzC0mEWJSckejSeNrsBJ6x1Mm1vAi+oI1afSyEr7xzTOaBSGjjFFtfXvdM7cxCr6GW0y+f1lZ2/A/dDMzGAwh31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiiqwuH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9DEC4CECD;
	Wed, 13 Nov 2024 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731502599;
	bh=JdloBukq50lNxkkXMIVzIjVCPbnmjAVlp6mKkRM9BcQ=;
	h=Subject:From:Date:To:From;
	b=UiiqwuH54lVASEQjtWpGhTnCkffXVRUC7P1/mRyCe7KDE+m2E6oKgtwAR1/6xydJN
	 5d0UfDhWzo+TibFOcUwIhnx8/vWPQkbd0ZN/0Fl/E1LWwS+aeY/55/pXv5xJjS9geq
	 BqRM1yuxGOxLL5hlZY3ELuMUIJK4gkSi6xDFysamgFqP43stEDZsHRluR8DSI3jcp5
	 PCYQZOQALy2RXwkkKesYiG1NVyp00DLALdys9iSDmFgDTN7tEC06KxhJvf+Q9PR9k7
	 TGKbor1amyWBRnJD/euLWRvizXFEsGTFL3os4D6rFJPpIWnJTXCJHAWnU84VXHH0g/
	 ldMSY0VlDfHTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0BD3809A80;
	Wed, 13 Nov 2024 12:56:50 +0000 (UTC)
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
 <173150260960.1209271.2528398268750650384.git-patchwork-housekeeping@kernel.org>
Date: Wed, 13 Nov 2024 12:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: imx: support word delay in ecspi (2024-11-13T12:18:31)
  Superseding: [v1] spi: imx: support word delay in ecspi (2024-11-07T15:35:19):
    [1/2] spi: imx: pass struct spi_transfer to prepare_transfer()
    [2/2] spi: imx: support word delay


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


