Return-Path: <linux-spi+bounces-6149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5C9FAD62
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4A163793
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5E176ADB;
	Mon, 23 Dec 2024 11:00:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB7171CD
	for <linux-spi@vger.kernel.org>; Mon, 23 Dec 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734951644; cv=none; b=spQBWcEgUxnpf9tErNCRd2dPd+du56goe+4QM9hTR6o03boU0Wtk/bZRRliPAfyarFjwDnN+yGDqtMOuAJOX0cvkXejVG8xQZQTLOG+9uENgxHvwwzh+M8DxtovIO5Tio/rkqzkWLU9uuQddfIIbOhySVkyTtqXotF5uFzYwa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734951644; c=relaxed/simple;
	bh=6RpOD068NwkvW5XoylpsrNJl6yexCOHwojuyKyNH5GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoJthoOdlUHasTMuoxv/u0sT2emexPMuCrP13em2k7A3sgM/nkyum4WUEz8r1BhbN67ABQtaQ+93I3tUeIE1FO6v62rNsS3jqCzmUCb/9yqcLEs2GHPVmk4EV8WtP//N7jfUdMu+nH7+Lu43LMQxDL8QKPvloCeyaEfP+6l0jJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.169])
	by sina.com (10.185.250.24) with ESMTP
	id 676942CC000012DD; Mon, 23 Dec 2024 19:00:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34066510748418
X-SMAIL-UIID: 63E10020A29A4FD792303C10ED5767CF-20241223-190030-1
From: Hillf Danton <hdanton@sina.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] virtio-spi: Add virtio SPI driver.
Date: Mon, 23 Dec 2024 19:00:22 +0800
Message-ID: <20241223110026.371-1-hdanton@sina.com>
In-Reply-To: <20240326112812.31739-4-Harald.Mommer@opensynergy.com>
References: 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Mar 2024 12:28:12 +0100 Harald Mommer <Harald.Mommer@opensynergy.com>
> +	/* Prepare sending of virtio message */
> +	reinit_completion(&spi_req->completion);
> +
Why is reinit needed, given init?

> +	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
> +				GFP_KERNEL);
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Simple implementation: There can be only one transfer in flight */
> +	virtqueue_kick(priv->vq);
> +
> +	wait_for_completion(&priv->spi_req.completion);

