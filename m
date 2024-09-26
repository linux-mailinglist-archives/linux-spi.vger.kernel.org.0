Return-Path: <linux-spi+bounces-4990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3DD986F60
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CEC28139D
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050D1A4F2B;
	Thu, 26 Sep 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dMko6XWw"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC291A4E9C;
	Thu, 26 Sep 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340911; cv=none; b=ERiSVYRGdXLGF3mnKJ51PNvwnB6/fT0G+bk48w/EApTe/KLOfUy5uskfHXIsjEIKRJJYLnsryLdz+DzK+/o/3wD5wncwfBQN1f3jrq8f9YBtJNeb35f4hQaBFnzz5DBV4LWuxmlow/2wq6YX2bjY2b14jy+O5vCihJhC1Qu/RdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340911; c=relaxed/simple;
	bh=pefF9FupOX3fcU18qX6EZA/ZGO1UAFIaKMKhdWk9q9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1rNbs+6l+E3LCKF26knscMgSDZU5u5SZp+XKBwPXHydeCvF1ArP1OeRiQm/2viuCyECHBuOTlAwDdZBolLMw9OmBMU5aCuPxpnwdrI3BQrmzD87+i5fJd/qw7G+GkHjCXoin7MUejNFRSg29uub64XZiyBxaLSWaN2ilcE9o2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dMko6XWw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lK1Yk/2ult1Hx8RcFihNnAte3glD+3mv3Tmf7ao1aR8=; b=dMko6XWwUdJhtSeWOyby+IQghr
	ecGOcea60fou56SJQnvJCgPYbYXSorztJxkUJNGSABpxr91Fgyd1t43QmoOa8vR9LYXBd6MqloJ4y
	tPUhQuna1z+UjV2RplZgiCOs/QVhL6aLxjAdgdfPAeAIOBExUXcT4FCcVOo0vc8OjVrUYBhfj2hC6
	x1E5giRQ7lJXFg3zHoy/c+PlFSP/yRc8aRqfDlom+2F2d8yAnNVKoVqu/9mhlxXeeoYlMoRnXhNvC
	hSjFOyqfYRz8cjYp5USm78pdKMdQ5uAMrxvClPKc5PXGQkiiHJ7HrzptLUJDONXUwCJqnjV4OZOCD
	2xPGIdPg==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stkH8-0001qX-4Q; Thu, 26 Sep 2024 10:55:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: rockchip: Don't check for failed get_fifo_len()
Date: Thu, 26 Sep 2024 10:55:01 +0200
Message-ID: <2382990.BjyWNHgNrj@phil>
In-Reply-To:
 <ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org>
References:
 <cover.1727337732.git.dsimic@manjaro.org>
 <ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 10:38:14 CEST schrieb Dragan Simic:
> Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep FIFOs"),
> function get_fifo_len() can no longer return zero, so delete the redundant
> check for zero in function rockchip_spi_probe().
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Didn't this topic come up in another recent patch too?

Anyway, having looked up the what the current get_fifo_len does,
the 0 case should never happen, as you describe, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



