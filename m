Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F034E80A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhC3M4H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhC3Mz7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:55:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1DC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:55:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d12so2547299lfv.11
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MChgLxBG8WhBmGOogHh3XiRA4X23nFAazTwrcPsLZ0s=;
        b=Z5KmwQlNg+ddr56xNjm1+C2KTy7uMEa3KLVrcvVzAeK6t634hzfeYqTmnNBSe1yPx4
         xrjQBtKB95+ovvb8baoh+4pYtpz6nss3IAudpCVO7ZucVem1emKe02weF4NqosXS6iUd
         Z6KiGIMJXTb56mBLrKJQhl3tE7mZusY0wUdff0SqAR6mm8rlq+cLUBRqiEtyBpxcdF82
         VlT488+DKCGgrHnwyAqdxdsg5hI2kGt062TtuAh04BlwUJBoxIbKhCGDErsboc6Ht71d
         dW1ZpkD3j48wzaDxf5oUui/TIXLzY85VSGfiviLER56norWdM4NH6pYFbcCLWw4hdggD
         rl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MChgLxBG8WhBmGOogHh3XiRA4X23nFAazTwrcPsLZ0s=;
        b=JzT5R5UQTOYBcIp4eFM/ewm18fB4X/LBIz2kxBqh14GhlpkvPkqoMFsXtOxCaEUXly
         mATAwvdbh93oKFTKOBe3utRO+efHYZi/PKldAyMUMrvSim7VAO2/ve1glEA3H8rmYL9V
         jHAnhtZoLAttZQrfpbhLUNPBbul7yTKxEdNwXFSuhqrnYviHUgVdlbXklblb7KnfX4OA
         MWZxp1IM5AGF/UQMPyZLYhT9mDsb5zoVCPnRmHrzPEdQPqxhysaTBoGy5iIrTtj/8LQU
         kBaZvG6vL0iQnlVMzGwR4H72daA2NaaB5fLmXCKz95MVHObyjpl3w+f4GhIwN5IDgaV3
         +GNw==
X-Gm-Message-State: AOAM531/IHqFoZpVK3PnoFCAv0JbjntB+EyPxTdNiPptXUVIbGrE+eM5
        mMaCH08ws3OUMm/zN1zcfivs0+kxSTFcp/0JuMo=
X-Google-Smtp-Source: ABdhPJwtU1t+w92iGGPnuG2hUKIaFapIylchT4+mNZ/L2T+27N+QuN/szod+4UCW54TKhA4bsPped5ufWPwFP7ppW9k=
X-Received: by 2002:ac2:520f:: with SMTP id a15mr18612824lfl.223.1617108957741;
 Tue, 30 Mar 2021 05:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
 <CAOMZO5A8r8LuV_GOvi3=rdABFgWuC3ho=h2B4FwWB_Y-WCXUTg@mail.gmail.com>
 <37cc380a-4df3-44b9-9d93-903a80617f77@huawei.com> <CAOMZO5C8BinwMDPSxL93UAMtXdw0VAFmpngGa6LhTZ3D44_r1Q@mail.gmail.com>
 <b47a2dbe-dd36-5eba-53ec-94822069f8bd@huawei.com>
In-Reply-To: <b47a2dbe-dd36-5eba-53ec-94822069f8bd@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Mar 2021 09:55:46 -0300
Message-ID: <CAOMZO5AZQRFBZ4FuG0KPaEG76j6s3WivzSyJCsupivQfwuWEnQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: davinci: Use of_device_get_match_data() helper
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 30, 2021 at 9:53 AM tiantao (H) <tiantao6@huawei.com> wrote:

> thank you=EF=BC=8CI will send a new patch for this.
>
> can I add Signed-off-by: Fabio Estevam <festevam@gmail.com>

Please add:

Suggested-by: Fabio Estevam <festevam@gmail.com>

Also, in v3 don't forget to change the Subject from
of_device_get_match_data() to device_get_match_data().
