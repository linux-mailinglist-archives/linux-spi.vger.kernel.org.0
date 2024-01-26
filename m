Return-Path: <linux-spi+bounces-872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A1683E2CB
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6291F22FBA
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492BF224D1;
	Fri, 26 Jan 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZFDDtc1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB23225A5
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298380; cv=none; b=fx+EtFz98PGmdUJyAxmKFd0NYffTl5FbF2e4llkj05hk7yrMsGv8oZ3MB4iG3lDQqGV9ZMs/XbIajv4LWuuYT+y711r+x/Xx6yrnZoID6i5o5cWvnI5Nznu1Sdo5YHDSTGb8mWJ0oa+RTHd58PknjTHEeKqhtMjNiofD9xNIfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298380; c=relaxed/simple;
	bh=42nKbvzxrhLtTO1/HhA5ZrxxRE9ibe+1064kf/7Xdy8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Qtw06sc7uR7ong5jaYk2QFMuQ+iyfCz1hD/Ik3ck479mJ0R5ronJ2Bn8WVARvFp/CfusxeKwyNngouy8smJLHJmfYrMMOAnQ0VXxMBRsxiAej3n79iMHUZyTA8i0hcuatomq66M+yuaR/MHtc4kV8YC+w2kY6eC90qY4YR760NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZFDDtc1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso16689335e9.0
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 11:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706298377; x=1706903177; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=42nKbvzxrhLtTO1/HhA5ZrxxRE9ibe+1064kf/7Xdy8=;
        b=YZFDDtc1fU+3jWmGYl2kBYvAvzMU4A58jQxEo/bWdHRnWDWUOAEsmPtoXfNrdWDO+W
         n4pgURS9B5Ffdi8B80c+/ceMH0Fc2memLWC1fIY/w1xmLRfGw0vZqJ2gl/2AxVdpsRom
         VaMXVZNBnCVSEM4GYzsz7twBfg2jv80JfgtKL/Wj6cCrjWCl5oc4G9yONt8Iit0E+Dcl
         +EPXIkiQds2z7+nHYXxuJYN7Oy5gL+F0htkFTz2p96VoV708ZmpqyQBwWzmYnyIFeFWx
         yGgJxEbLzURgSHzaUNx2ZasCwEkvs6xiIyjeJLU77ZiUTlmwu6/jQCvHgasGSGy93wiV
         ahcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298377; x=1706903177;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42nKbvzxrhLtTO1/HhA5ZrxxRE9ibe+1064kf/7Xdy8=;
        b=MRDJkDdkfG5zfTHmPct8loq+fgQVNyduheDC3v6nhBSyRi3E0vvi8T4DZ95QLo+Til
         KSsn6Ku7KyqHwHt+TxLSlkrWs6pn4H0NjT+D4whQ+Yh9sH9kYnO5+oUdqF56egzpVaXr
         XUT7YHj4lnS0VR4Qo/HtrFyyDnfEppxBfxrc3peUTfG94i4yBO8Am386MpZ1Elk3q/zz
         6ewjRr1RbT+hKCjKqb0se8Dv0md+XFZa6Blrlsyw/YqxdLn1/jmp7eFZ53nbeNvr/53H
         wYkCRl9s2UXCKmFapH5lyd/Qts9FmjdHWwTx40fcfxRfWDxHs1WTkzd8Q0MbG5zr99t+
         CyuA==
X-Gm-Message-State: AOJu0Yxq/9EOxCn00qWFiqbilxeXOYk9Tjth4IX1igin/w/jEXrKInQc
	k0DXsMwto8Uevzl7d+1MivKuK2JhVjF5oJ3+zfdMYTqCRbZq/cO8a+UNhRWKlz/PPg==
X-Google-Smtp-Source: AGHT+IG5ZcuFua96Ii9AFQF3yBsEPz4LeP31TI+oooY7YAJiWQgsXgZlF9VKTtO17a4vWy2D/+l6ww==
X-Received: by 2002:a05:600c:3d19:b0:40e:e945:1baa with SMTP id bh25-20020a05600c3d1900b0040ee9451baamr214623wmb.141.1706298376685;
        Fri, 26 Jan 2024 11:46:16 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id bp19-20020a5d5a93000000b003394495566dsm1917666wrb.22.2024.01.26.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:46:16 -0800 (PST)
Message-ID: <08e518f54f94b78a3985a3c9247bced5b275433b.camel@gmail.com>
Subject: [PATCH 0/3] spi: spi-rockchip: Fix of chip select lines handling
From: Luis de Arquer <ldearquer@gmail.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org,  Robin Murphy <robin.murphy@arm.com>,
 luis.dearquer@inertim.com
Date: Fri, 26 Jan 2024 20:46:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This patch series has several fixes concerning spi-rockchip handling of chi=
p select lines.

Probably the more important issue is an out of bounds access to an array, f=
ixed on
the first commit of the series. The issue was found and reproduced on a dow=
nstream
kernel (orange pi 5 plus), but it seems to still be present on mainline

The patch has been made and built on linux-rockchip tree.
It will take me a few days to complete proper testing, but any comments at =
this point
are welcome.

Also, this is my first patch, so let me know of any side issues with patch =
or email
format :)

Luis de Arquer
Inertim Research

