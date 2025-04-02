Return-Path: <linux-spi+bounces-7396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2CA79229
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A093A34F4
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40A23814E;
	Wed,  2 Apr 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLzCUVsR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D842E3385
	for <linux-spi@vger.kernel.org>; Wed,  2 Apr 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607798; cv=none; b=dVdnFTcfH41txoWC61/yK79YvijfKkQUQLykzzm497fFvJkkMPhjST2f2T4SvZVHTDYNQE2iiyfud5J01Hd94ZBIA8lS0GFjT1n9XSwSiD+BOwmvNEpjLEXPuGSItBjWZQa/vX7gjg+sqYWFxS2smQLyXvwjlXDmVoGB5AS7mGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607798; c=relaxed/simple;
	bh=TkdcvT4d9U41S8UhlA9xOAOIXi0IB3H80Tnw11o46PI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=duX1FWf6bSF3Wre+VSkqwzRHHOcoT384ugAYhIMlUdC2Q7f5XiNGUxYHoA0ijIq2R/Z5JqOLgP5CIlvhEGd7hx4swLIkMY6U2d3HCynX+Vvw5XWq9nC0zRA/O3WakH6TbnaavOAQ/GYI/7y2KpVyJ+xmmllANHJt8JXnNECGio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLzCUVsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE40C4CEDD;
	Wed,  2 Apr 2025 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743607797;
	bh=TkdcvT4d9U41S8UhlA9xOAOIXi0IB3H80Tnw11o46PI=;
	h=Subject:From:Date:To:From;
	b=kLzCUVsRkj7zuq+aWEzSJrQVFRveLG/F1t1M271CRDRcGeNQ6sOUipuGiU81zA/dO
	 SXE3OtuC2FRTe3n7e6cmEkk/XSjyor9eU5g503nfQ9x9G79KlBpjqpxxfxIEZCI82v
	 zr/oW3zndibrlQ8GKhVh/3FCUSD0m06P6r7Fl5qNK6gRZbpZNNQ4z4c6GW9ySpw2Go
	 AF4p4Nq5NDgXlIPi/ryT8ofNR9i+lWk5AmTiojkoSuc0I+s4F03IPlo9j+SfXxM8/q
	 jYJJIhpZbkSSLMKsR6NyaJc7dillrSOqL5N7GENONp7DtA9o8fgVkd2t2/BJG/fIPN
	 07ODcsvGz+v4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4F67380DBDE;
	Wed,  2 Apr 2025 15:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174360783431.1578741.11494719192182308233.git-patchwork-summary@kernel.org>
Date: Wed, 02 Apr 2025 15:30:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent
  Submitter: Florian Fainelli <florian.fainelli@broadcom.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=949116
  Lore link: https://lore.kernel.org/r/20250401233603.2938955-1-florian.fainelli@broadcom.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



