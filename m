Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E3A15D710
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 13:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgBNMCg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 07:02:36 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35032 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNMCf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Feb 2020 07:02:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so3485328ual.2;
        Fri, 14 Feb 2020 04:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFC9dwFHK1mzjYzDWxuDe90yFjwDGIU4f9whKR8MGAY=;
        b=JKCar6pj/ASMWyJpNleN7pbp0dyArkEs88OguD6coBhE1pr1fwmymaeyZKPlFQenCO
         Ij13L6t1qkImGym6RwJBn5m2XSq1SuafiB3kUf34hGoWVlEakbTLRlab57OVCqREe7VP
         CjufXqwaxRg/jnS8ZMePd++wDzDyx2cZDr3oI82MNS8mZNNIAJOO2KsQd2ELrILzR9Ap
         SNn92+ImeTXv4haKJmzuTZQtitKWplmgWQV69FjvmNCWXERDoDeuW3eEN9juuk798ph2
         HsQFbDJe1PTgjpfABdHIJeNtb5yVEkCf2amGzD9RxV0+w7QCFBPSHy8YbbEh/odat4pz
         zfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFC9dwFHK1mzjYzDWxuDe90yFjwDGIU4f9whKR8MGAY=;
        b=D9n4x+d7xBK7RtzoMMgSt+nIykUXv2+i+11XhCMA/vjsyCRCJ/R7rQPw2/wD7uOVPl
         YeWAO2UAVU85nfi4vQBL3t6pqFORPwHVqD6SqwnmU/MVUZOBcFpKKDBaYQyBjTSZOweX
         YoEO9h9HBL2Cr17XDEhIZJHxw6MrGpW2n8XCu8A7mKTeqWcvtEDV9GbAzO0fokpXI9gZ
         i2SL3NVx8hrLbnxPYtqZMTcdg2Nda4KEyDJ/cXOr0W2UEQL8Whj+n5JliD+lKPw4mypa
         0BX2KDNewAvWTt4Yd65PtEedb2eJIX0i9e01izcZkUvNUwU05B2oRktlwAr4n4xW49UB
         h+UQ==
X-Gm-Message-State: APjAAAU3fDQz3ifzLRauCY99i1QphsXNPq2408e3ToO37qpUDWkl+BvU
        lhKy3+d3tDdfaOu4c/BfnK8Q9Vc70nSsO6UFT3KneE4h
X-Google-Smtp-Source: APXvYqyleb/uNXK8RD75c+aooj2pQHxNQcIawrJB8QaRAtsurc+txQbdJtecHlm3Hlnyf2tQfH8oYjOJ1COdOkPpCIM=
X-Received: by 2002:ab0:2a1a:: with SMTP id o26mr1287024uar.62.1581681753961;
 Fri, 14 Feb 2020 04:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Fri, 14 Feb 2020 13:02:22 +0100
Message-ID: <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.

This is v9 and still, none of the altera maintainers are on CC?
How will it be ensured that this doesn't break altera if it is merged?

Regards,
Simon

>
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
>
> Thanks a lot!!! Vignesh for the review, suggestion to optimize the patch.
> Tested with mx25u12835f on LGM platform.
>
> changes from v8:
>  -- remove the depends MTD macro
>  -- comment into C++ style
>  -- remove spaces and tabs where not applicable.
>  -- align the macro string as same as existing one.
>  -- replace QUAD to op->data.buswidth variable.
>  -- add CQSPI_NEEDS_ADDR_SWAP instead of soc_selection variable
>
> changes from v7:
>  -- remove addr_buf kept like as original
>  -- drop bus-num, chipselect variable
>  -- add soc_selection varible to differetiate the features
>  -- replace dev->ddev in dma function
>  -- add seperate function to handle the 24bit slave device address
>     translation for lgm soc
>  -- correct sentence seems incomplete in Kconfig
>  -- add cqspi->soc_selection check to keep the original TI platform
>     working code.
>
> changes from v6:
>  -- Add the Signed-off-by Vignesh in commit message
>  -- bus_num, num_chipselect added to avoid the garbage bus number
>     during the probe and spi_register.
>  -- master mode bits updated
>  -- address sequence is different from TI and Intel SoC Ip handling
>     so modified as per Intel and differentiating by use_dac_mode variable.
>  -- dummy cycles also different b/w two platforms, so keeping separate check
>  -- checkpatch errors which are intentional left as is for better readability
>
> changes from v5:
>  -- kbuild test robot warnings fixed
>  -- Add Reported-By: Dan Carpenter <dan.carpenter@oracle.com>
>
> changes from v4:
>  -- kbuild test robot warnings fixed
>  -- Add Reborted-by: tag
>
> changes from v3:
> spi-cadence-quadspi.c
>  -- static to all functions wrt to local to the file.
>  -- Prefix cqspi_ and make the function static
>  -- cmd_ops, data_ops and dummy_ops dropped
>  -- addr_ops kept since it is required for address calculation.
>  -- devm_ used for supported functions , removed legacy API's
>  -- removed "indirect" name from functions
>  -- replaced by master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL | SPI_RX_OCTAL;
>     as per Vignesh susggestion
>  -- removed free functions since devm_ handles automatically.
>  -- dropped all unused Macros
>
> YAML file update:
>  -- cadence,qspi.yaml file name replace by cdns,qspi-nor.yaml
>  -- compatible string updated as per Vignesh suggestion
>  -- for single entry, removed descriptions
>  -- removed optional parameters
>   Build Result:
>    linux$ make DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml dt_binding_check
>     CHKDT   Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>     SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>     DTC     Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
>     CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
>
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: spi: Add schema for Cadence QSPI Controller driver
>   spi: cadence-quadpsi: Add support for the Cadence QSPI controller
>
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  147 ++
>  drivers/spi/Kconfig                                |    8 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-cadence-quadspi.c                  | 1508 ++++++++++++++++++++
>  4 files changed, 1664 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>  create mode 100644 drivers/spi/spi-cadence-quadspi.c
>
> --
> 2.11.0
>
