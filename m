Return-Path: <linux-spi+bounces-4989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059F4986F58
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D511C21702
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD31A4F2E;
	Thu, 26 Sep 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rcXvHeWw"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366118C32D;
	Thu, 26 Sep 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340815; cv=none; b=odpRotlNeQGdTfDPAJsAGWNexbpG7BVSx5ygRH2/lECZ976lKiKUtRGuoHSvf1ybAwQMm18kkQMr7tI0sy7y4OIKVanrGax5YmE6Y2Z2uBx+2QBZ1lFZVJiP4QQqcY7Lp3xFLFxR+wE5HY1Fg7ci7pRLholn8DKONeqUN0qQXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340815; c=relaxed/simple;
	bh=uHd/q2BZ/x0Dq735s50VeInesEaCC9A2PGAQ9J6VxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh7d9pMlIC31jtBYTx7KtfUvaOIEdLLoE3jCSS00OoAa3Sq0Mc/yCiYuOat5M0tHMRVSNu+UyrA50Ox5lJJggyenPL3RRTlWEe3QErUAG462+IlPN9pSd4r8zuY9Wv97WD/AtOXkCiY5hc1kcuqa7mZUyHNC7vWttpXZ2dzNnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rcXvHeWw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h9TwpCiYQE/OwndpVtZUJ53LRBPCowtcZ116a9noSco=; b=rcXvHeWwNbuYXMVajDDGJpUi7Q
	ou+zZj0lfCgez/iMkZov75rYRHNDbfl4YigONPwXmdJe3WXLIDLRE6Vzrc52rF/SvU7idi+/227mN
	DLjkCjqPLrN0iiNgrkp5DUs/7gSBsRjn4Bm4enqMSon3+XFkHrSiBKA34mKxd/ycTucPudGShntS9
	h7MtKdBynJqRrHeKkMPplBcfwZ366puBPnkqTTam1B4WPzLkRmv/PhVTuTF9l4OrugrW/O04TVdml
	QHSllCuZKLbNk7ohWyhrkbwdx8cCZSdbfsuUegRZj57p+l2V6BD9J5JmnlHIlf5FqbYki0mgVkKoy
	b6qV/mRA==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stkFZ-0001pw-W4; Thu, 26 Sep 2024 10:53:26 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] spi: rockchip-sfc: Perform trivial code cleanups
Date: Thu, 26 Sep 2024 10:53:25 +0200
Message-ID: <2285557.3ZeAukHxDK@phil>
In-Reply-To:
 <251242bfc9c4fdc01d930f093022ce0c9481d58e.1727337732.git.dsimic@manjaro.org>
References:
 <cover.1727337732.git.dsimic@manjaro.org>
 <251242bfc9c4fdc01d930f093022ce0c9481d58e.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 10:38:13 CEST schrieb Dragan Simic:
> Perform a couple of trivial code cleanups, to avoid unnecessary line wrapping
> by using the 100-column width a bit better, and to drop a stray empty line.
> 
> No intended functional changes are introduced by these code cleanups.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



