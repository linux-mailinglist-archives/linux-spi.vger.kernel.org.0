Return-Path: <linux-spi+bounces-11087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CEC3B951
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 15:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77E96404B9
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D9335072;
	Thu,  6 Nov 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujSeXOPz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D3334C3F
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437447; cv=none; b=dueE7vTKSkH7sEjgj86HJXQylr4I7fF8Y/CNbL/t9N1bH/8RoaXlciT+gVox2gw/2USypnbPPt7drxA+rgukPMfh88NFncfC0KmtBQyFiLVzZc9Teg33QGSPXCACfsnFJzfWTaZq6s8ZCt5a64YP51oyFBPJW+U+tQX/UTbxQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437447; c=relaxed/simple;
	bh=lDKY7XUcp9sAmcVDpVq5PQoSxomAYTtwFyC+bjd1u8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j4XwpiOEx8Hpc9AIiVaHGpV3TDJQjXFkOVjfLLmgFx6SCCJlgfP9ZZU7L2O3ejwFmNhf6BPFtHHj2gsEijtg/ksRyst8AHRGFNVj9Q3okIKH4BOwvP22Bp+bVBJQ1NUzWzVLIr7puQvgUuU0PwSb+d/2f6GGWtGtqAoUbO58p48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujSeXOPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4E3C4CEFB;
	Thu,  6 Nov 2025 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762437447;
	bh=lDKY7XUcp9sAmcVDpVq5PQoSxomAYTtwFyC+bjd1u8c=;
	h=Subject:From:Date:To:From;
	b=ujSeXOPzH2Gkrqo+PROFmnekn1LSqsty+m5Q7D1XQEdspoHjysEMNwpVoz4B2M0dY
	 UoiBDpq1Gxe3nEmFcixES6fui93Lcqi8WiabfOpIByPTsFujeUpr1oJTgwXU+EQEV0
	 D9UTN3C2FkTtH6MVQsMd8ZE9vjRtS35C2cEnLZfLiKHBhh+0I/SOYn+QQBtEQ4OUEV
	 1F7kjJPMFs79wA3noRQ6p95dVrBzjSy/OuJ8MUNINN2JDKcDTemBMcmI4UnKS2RwwU
	 oRAgmyocJf2LA9vbFQAM+nkETdM81utrHQdfbr1GYbmsFh8SM2SBCPnnwBphSG0VZ9
	 fdneGexLrEU+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9C39D0C9B;
	Thu,  6 Nov 2025 13:57:01 +0000 (UTC)
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
 <176243742035.216107.14717519144520313381.git-patchwork-housekeeping@kernel.org>
Date: Thu, 06 Nov 2025 13:57:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: xilinx: increase number of retries before declaring stall (2025-11-06T13:45:35)
  Superseding: [v1] spi: xilinx: increase number of retries before declaring stall (2025-11-06T12:14:04):
    spi: xilinx: increase number of retries before declaring stall


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


