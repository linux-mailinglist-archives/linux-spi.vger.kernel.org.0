Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5006B27A9D4
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgI1Io0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 04:44:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32865 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1IoZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Sep 2020 04:44:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id e11so3874917wme.0;
        Mon, 28 Sep 2020 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mMFVfHkuFc+oREAqCSuRzqniaXnxrZGMqaf+ROp/CQ=;
        b=c3z2dB52OWDAP3o8Pm7nMTsaXcXTliYRa/HcNKZKcHMpAonDO45VNZBjmC/gmtnGlG
         W6BwPXMLLbtKjVNBOhoB+K9mgu+Yj/ux9vPfXuZm5YWRt05J79gs1hOyRdla0mmivboh
         XzHUCETGb/k3XVJtvByvumsv7JxHP/U4mnKyrLTmihvcsN7CNEtIKqD3FxpcQqLDBMYe
         WaSW3iUNsP0guYB2N7L5BfczCtKdhZ5sapMd1KgvX5XO5VxDwuRVW3OlndafZiXZ3jBo
         r7wgRuEorB1UPHhzSK9nUa++8ydbVNdh95d7nsnSMfe1Ps001eKWJRQkBoXobdo8WB9d
         Z/0A==
X-Gm-Message-State: AOAM533U0ST+Hm9gtaC/PAU3Afqqvu2WUp10fMgPiPiSNmUngXc/dNyf
        qz4mzaJ9XpXDYumuRpckda4=
X-Google-Smtp-Source: ABdhPJxEDLF9GjchnJodWAWlW63fhjbkhRB7nvp4u1mlwWMprWN0sDPvavZLOdsWoG19e8pBGcVdhQ==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr479774wme.140.1601282663613;
        Mon, 28 Sep 2020 01:44:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.132])
        by smtp.googlemail.com with ESMTPSA id n21sm342046wmi.21.2020.09.28.01.44.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 01:44:22 -0700 (PDT)
Date:   Mon, 28 Sep 2020 10:44:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v2] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20200928084420.GA9807@kozik-lap>
References: <20200928083238.27137-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928083238.27137-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 28, 2020 at 10:32:38AM +0200, Michael Walle wrote:
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove
> path") this driver causes a kernel oops:
> 
> [    1.891065] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> [    1.899889] Mem abort info:
> [    1.902692]   ESR = 0x96000004
> [    1.905754]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.911089]   SET = 0, FnV = 0
> [    1.914156]   EA = 0, S1PTW = 0
> [    1.917303] Data abort info:
> [    1.920193]   ISV = 0, ISS = 0x00000004
> [    1.924044]   CM = 0, WnR = 0
> [    1.927022] [0000000000000080] user address but active_mm is swapper
> [    1.933403] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    1.938995] Modules linked in:
> [    1.942060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc6-next-20200925-00026-gae556cc74e28-dirty #94
> [    1.951838] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
> [    1.960135] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> [    1.966168] pc : dspi_setup+0xc8/0x2e0
> [    1.969926] lr : dspi_setup+0xbc/0x2e0
> [    1.973684] sp : ffff80001139b930
> [    1.977005] x29: ffff80001139b930 x28: ffff00207a5d2000
> [    1.982338] x27: 0000000000000006 x26: ffff00207a44d410
> [    1.987669] x25: ffff002079c08100 x24: ffff00207a5d2400
> [    1.993000] x23: ffff00207a5d2600 x22: ffff800011169948
> [    1.998332] x21: ffff800010cbcd20 x20: ffff00207a58a800
> [    2.003663] x19: ffff00207a76b700 x18: 0000000000000010
> [    2.008994] x17: 0000000000000001 x16: 0000000000000019
> [    2.014326] x15: ffffffffffffffff x14: 0720072007200720
> [    2.019657] x13: 0720072007200720 x12: ffff8000111fc5e0
> [    2.024989] x11: 0000000000000003 x10: ffff8000111e45a0
> [    2.030320] x9 : 0000000000000000 x8 : ffff00207a76b780
> [    2.035651] x7 : 0000000000000000 x6 : 000000000000003f
> [    2.040982] x5 : 0000000000000040 x4 : ffff80001139b918
> [    2.046313] x3 : 0000000000000001 x2 : 64b62cc917af5100
> [    2.051643] x1 : 0000000000000000 x0 : 0000000000000000

You can skip all these addresses/registers, so only keep OOPS message
and call trace.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
