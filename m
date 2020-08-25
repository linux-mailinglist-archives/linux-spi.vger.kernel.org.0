Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F5252200
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYU2m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYU2l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Aug 2020 16:28:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19701C061574;
        Tue, 25 Aug 2020 13:28:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i14so5080518lfl.12;
        Tue, 25 Aug 2020 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScwefOF0IlMENPyIZhCD/hmv3+qRcSPN2swhgn0oOR0=;
        b=iTtlXxM4k6LBcoR/F2FfFJ6fkaIScVRj02cFdKoJENO/JAdd9ubNUbN4pzzbsn2wlD
         kIP9gqDEciZw51RWNO9Ad8O0mxr3ZX4qVWiwo2USKJpGjvnqqQabISJ1xmp2ePd8GXLD
         rO700yEmTngQUywPqGEcfrgKWOjkYPuhn8ICNOMe73gomUgiEuarBmmKVBaaF1VYMrpS
         lxO1Xl6opKhKgGJRO2VRtQyBYK6TtTPl8mc+R3bYA+YsKaSpXI3BDaTn/Jc4B50O8yn2
         0ZVAitu4i5fqBhA62yUcAZATy0Y7y+VahmKs38PqGlb6GoUV4pVMjMBdmQ3YXEe0UyIa
         kOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScwefOF0IlMENPyIZhCD/hmv3+qRcSPN2swhgn0oOR0=;
        b=M78oOnku4MeWpFbE0GcrpG1wc41Nxb1nfbAqp2PNbExoJQnz8e5z1kNmNMdz8ZLnIO
         vVOTB82fwa6N5oojNUlWnB0MqWowmR+ZfC35bTPe3lQfZQhEUTz1msCh/9UF3xXkXxPo
         6JRvcC9+70ehE/KghUR6Q2bx9vjQLLVtnqm13rafg8/HKkAoZw+WQ5mYu9cW8YGrfGr+
         EaifXqY3huRSeEu0sUIehN9NEHG9nae0ncV9YTPLL4rdrduneF9DWGTu5AqtOML2hYjZ
         DgnR7Wl1f1nSyEKzSpxWT+LJ4HVx02brG7E6OU7WqHSPseqJZBfMHIU21qaZxq7AbUUx
         cI7w==
X-Gm-Message-State: AOAM530zk0qO4aygRuFroxzEWGyaoYMLgqsqagULR6GTkjDCIfDQtsIG
        XHjxUVx5HWx68wKwgjH822VJBVdwwAZ0/4zTD14=
X-Google-Smtp-Source: ABdhPJzDq9EN1YJyQ6bL5cSyprPRzjQ3T05GfVShr4z/GIN1qVC5M8gJSRlxmobsuAAQFJaYAWbqi3TmEmQCOYMOG18=
X-Received: by 2002:a19:4ace:: with SMTP id x197mr5620754lfa.70.1598387319510;
 Tue, 25 Aug 2020 13:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Aug 2020 17:28:27 -0300
Message-ID: <CAOMZO5CK5wbEkTDETfiaWuNHW_33RCFW_qsZnVOMcoDRi49F6A@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-espi: Remove use of %p
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 25, 2020 at 2:10 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> The register offset is already included in the device name so even prior
> %p values being hashed printing the base was redundant. Remove the %p
> from the dev_info() output.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
