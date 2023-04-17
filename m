Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8A6E4740
	for <lists+linux-spi@lfdr.de>; Mon, 17 Apr 2023 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDQMMS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Apr 2023 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjDQMMP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 08:12:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608787D84
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 05:11:52 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n193so2991822ybf.12
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681733504; x=1684325504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TewJ1RrFHFrg7FTQB5xmBV0f+ig0UTnQJKvATVOD0E=;
        b=rsLcVCd9c/lWXu+hqwU7xr78XK7eJjKhocggDxrsnlpFfDL/HVByDq3FRzT2Wi4U0v
         /TzNSif4wL1kd8nip3b1rTP3eOrRQaw1MgGUd6BfNANOwoD/XOrEBI6CFI/P0WJwUV07
         NFfoVbGY9G7LUs4mibE09Myap/NeV82aIU544JGsl3Brq8tG5PBemFPamoRyLosDe+IH
         0B/pbOrmzm86NgFMbUzgWMs/aBOZYhExkVDjGx7ufXzqpNanLdiNgQMIQpjT6t9LQeq1
         nKDvIIqi/qA97aZgfEJDcrMPEuTIrTsDCpFgwTSW3G/73ey5u8asPxF7VkFAdcErtnT3
         IGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681733504; x=1684325504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TewJ1RrFHFrg7FTQB5xmBV0f+ig0UTnQJKvATVOD0E=;
        b=FrS/7T+S7xscVJS8kd3A5iKHsLBeZOxfokWVNxLFo/Yl6pNIB8tXpFGsX7L6A8pcD8
         jDejOlMvlbAHHr+8sVRUJA2BhYDMo2KTP8tzO36RCvkaFty3w+6YMeZ4K7xZlkIH0W3H
         FtmolJWTUrN75GKcTRT/CYFmuzrfEJkx+Ewo21OyFRBLpKJsAJOSCnfij62CgSpO9rUI
         3OFXdDFjF7/k/a0/PX8ttSyCCOtvAb67SugCx3TllyGJt4g0tcIOlrAuMV3PUM0o3Y0I
         pHZFz6FMEmtRwyAwB2pz4J9kg745cWCTVSi63wwWpvBH+IaQJUcCQnTbyARvj5BltWRL
         xnNA==
X-Gm-Message-State: AAQBX9cdJWXK7MWTTKlaL6a6o0ob+0D/sQ+jRxpEjnlNrAgzPCTFeswE
        +PT+NaACBI7vgPPwFqHB+iE741mIAc+mdKzbnGUfgg==
X-Google-Smtp-Source: AKy350YQmqxxlG21q6qsKKF+2V3NVv5YB/5z35qB85vLgRO0iR0vL3tnW5Om/gBzYxnToHYTtt1owMW3C++tpBSN5qo=
X-Received: by 2002:a25:e082:0:b0:b92:3917:d925 with SMTP id
 x124-20020a25e082000000b00b923917d925mr3003107ybg.8.1681733503853; Mon, 17
 Apr 2023 05:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230414120520.360291-1-joychakr@google.com> <20230414120520.360291-3-joychakr@google.com>
 <ZD0iycNg4i6sYO48@smile.fi.intel.com>
In-Reply-To: <ZD0iycNg4i6sYO48@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Mon, 17 Apr 2023 17:41:32 +0530
Message-ID: <CAOSNQF33jw8uKuxsjjGmmLG6vG9vbky6FCN6Ts5-KZ88YLxmQw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] spi: dw: Move "dw_spi_can_dma" function
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Apr 17, 2023 at 4:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Apr 14, 2023 at 12:05:17PM +0000, Joy Chakraborty wrote:
> > Move "dw_spi_can_dma" function implementation below
> > "dw_spi_dma_convert_width" function for handing compile dependency in
> > future patches.
>
> We refer to the functions like func().
>
> ...
>
> > +static bool dw_spi_can_dma(struct spi_controller *master,
> > +                        struct spi_device *spi, struct spi_transfer *x=
fer)
> > +{
> > +     struct dw_spi *dws =3D spi_controller_get_devdata(master);
> > +
> > +     return xfer->len > dws->fifo_len;
> > +}
>
> > +
> > +
>
> Single blank line is enough.

Sure,I will make these changes and send V7.
Will wait for some time to see if Serge(y) has any other comments on
the patch series.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
