Return-Path: <linux-spi+bounces-253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580C810A5A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 07:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870121C209D1
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F4FBF6;
	Wed, 13 Dec 2023 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evNq0Xwz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F5E8
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 22:33:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5be30d543c4so3708520a12.2
        for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 22:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702449218; x=1703054018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9p8/aS0DcOZN8+84ZMld49VFTAkEWGnyTWKIx1cHbc=;
        b=evNq0XwzahMVneMz4TCwG2wxhmKEIHETEyfHGBWFyT8XNLj8ql7U1AtLon+ZALAvh+
         ppqrFtFgS5b4WnO0adchdrLK6S/JOpZuQjvnIuiwvdsudtO+gTNHugLQNPU9MoAg0xL8
         auwEkRPHcDDeRlmISsClP110t6UwNtYi56SuvI+fP1aSY8wguxNzTUjtOUVyhKGdOgOF
         WogBzdG5fzl2GHKeyQCvx8k4THNtNwCA9U+NvO1Loz3RUe8rrcGuSYflBN92WKtZ5L85
         VDt7ZVD3fTK3ZAEeovIxq0AsuVE1O/YgH+RGuUhqidwfSOO1rnF4KPnVrhaguYOKn88t
         LTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702449218; x=1703054018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9p8/aS0DcOZN8+84ZMld49VFTAkEWGnyTWKIx1cHbc=;
        b=CuMF+42gh/d4zuirQu0D6tSrjrEqx9yeHgzCj0qpqbztoZEPLV1k11RQpnTFhaYVuj
         pFa2Z7E0X2pRZGp/NvCUO3QExn+zyPhtWlV2zR+Y5vD3Vmzp8/8xjXOPCphfcD10Ne91
         AK8l4hNVp9arvSZSCTxawXScDODhkMX1NJZQg8uMcTE/P1tUOlgDaONQoqXlmfYf2COD
         PZT3upMQkfwwEq7WKosDe/qT1mHvEAjSySS32F43BLMuiDhVTgDlDlDytxwV9iOLaI4P
         cMaLqaJ8awE/HHz9x2V41of0aB1Aaak58tz31EC8Nqq91fq3YPK14GteEqFvcJU5IRbf
         2iaQ==
X-Gm-Message-State: AOJu0Yw/f4GYSzNhMp5WqW3ZZqb9RREX22TGnKwAYZqVtistZhMOWR2d
	dPuNJEkZfE6ccba/uF05ddJM+z0OaNiaFKL4ggc=
X-Google-Smtp-Source: AGHT+IFczjvcizzn2ujL+SLGH7PssuoA4yNSPN+Tsz72PXu63XHsPUs7UAvlcsskYUd2hV4r0ktChA==
X-Received: by 2002:a17:903:1206:b0:1d0:9a6b:52ab with SMTP id l6-20020a170903120600b001d09a6b52abmr4442562plh.45.1702449217991;
        Tue, 12 Dec 2023 22:33:37 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902eb5200b001cfc42ccfcasm9667197pli.152.2023.12.12.22.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:33:37 -0800 (PST)
Date: Wed, 13 Dec 2023 12:03:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
	quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [virtio-dev] [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4
 draft specification).
Message-ID: <20231213063335.xaejh3565gkn5cvh@vireshk-i7>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
 <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
 <87f06ede-ac54-48cd-8135-ea2c8f5548f3@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f06ede-ac54-48cd-8135-ea2c8f5548f3@opensynergy.com>
X-Spam-Level: *

On 12-12-23, 19:58, Harald Mommer wrote:
> On 12.12.23 11:34, Viresh Kumar wrote:
> I'm working on V8. It's coming to an end, will still have to check some
> details but it's close. Internal review pending. Now there is a V9 and I
> will also have to look at this. Maybe I will send V8 and subsequently update
> to V9,

I hope you are talking about V8/V9 of the spec here, as I only see one
version of the Linux driver on the list. Please keep me in cc if
possible.

> > On 27-10-23, 18:10, Harald Mommer wrote:
> > > +++ b/include/uapi/linux/virtio_spi.h
> > > @@ -0,0 +1,130 @@
> > > +/* SPDX-License-Identifier: BSD-3-Clause */
> > Maybe this should be:
> > 
> > SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > 
> > ?
> Looking into what others do here. virtio_blk.h, virtio_input.h and
> virtio_iommu.h for example: None is using GPL-2.0 here. virtio_iommu.h is
> using exactly the same header as we do.

Looked at all headers for SPDX License in include/uapi/ and this is
what I see (Yes there are many non SPDX licenses there):

    522 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
    106 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
     18 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
     16 /* SPDX-License-Identifier: LGPL-2.1+ WITH Linux-syscall-note */
     16 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
     11 /* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
      6 /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
      5 /* SPDX-License-Identifier: BSD-3-Clause */
      4 /* SPDX-License-Identifier: LGPL-2.1 WITH Linux-syscall-note */
      4 /* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
      4 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
      3 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
      2 /* SPDX-License-Identifier: MIT */
      2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
      2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR CDDL-1.0) */
      2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
      2 /* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
      1 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR MIT) */
      1 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause */
      1 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
      1 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note*/

Also Documentation/process/license-rules.rst says:

"The license described in the COPYING file applies to the kernel source
as a whole, though individual source files can have a different license
which is required to be compatible with the GPL-2.0::

...

Aside from that, individual files can be provided under a dual license,
e.g. one of the compatible GPL variants and alternatively under a
permissive license like BSD, MIT etc."

And so I thought we may want this to be a dual license.

> > > +/* All config fields are read-only for the Virtio SPI driver */
> > > +struct virtio_spi_config {
> > Can you please add proper doc style comments for the structures ?
> Checking my current code. This is updated in the V8 version.

V8 of this patch ?

-- 
viresh

